#!/usr/bin/env ruby

require "date"
require "pathname"
require "set"
require "yaml"

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

ROOT = Pathname.new(__dir__).parent
STRICT_DATES = ARGV.include?("--strict-review-dates")
ALLOWED_SKILL_STATUSES = %w[candidate trial dogfood core paused deprecated archived].freeze
ALLOWED_AGENT_STATUSES = %w[concept trial dogfood core paused deprecated archived].freeze

errors = []
warnings = []

def load_yaml(path, errors)
  YAML.safe_load(File.read(path, encoding: "UTF-8"), permitted_classes: [Date], aliases: true) || {}
rescue StandardError => e
  errors << "#{path.relative_path_from(ROOT)}: invalid YAML (#{e.message})"
  {}
end

def frontmatter(path, errors)
  text = File.read(path, encoding: "UTF-8")
  match = text.match(/\A---\s*\n(.*?)\n---\s*\n/m)
  unless match
    errors << "#{path.relative_path_from(ROOT)}: missing YAML frontmatter"
    return [{}, text]
  end

  data = YAML.safe_load(match[1], permitted_classes: [Date], aliases: true) || {}
  [data, text]
rescue StandardError => e
  errors << "#{path.relative_path_from(ROOT)}: invalid frontmatter (#{e.message})"
  [{}, text || ""]
end

def duplicate_ids(items)
  counts = items.map { |item| item["id"] }.compact.each_with_object(Hash.new(0)) do |id, memo|
    memo[id] += 1
  end
  counts.select { |_id, count| count > 1 }.keys
end

def parse_date(value)
  return value if value.is_a?(Date)
  Date.parse(value.to_s)
rescue ArgumentError
  nil
end

needs_data = load_yaml(ROOT.join("registry/needs.yaml"), errors)
skills_data = load_yaml(ROOT.join("registry/skills.yaml"), errors)
usage_data = load_yaml(ROOT.join("registry/usage.yaml"), errors)

needs = needs_data.fetch("needs", [])
audiences = needs_data.fetch("audiences", [])
skills = skills_data.fetch("skills", [])
runs = usage_data.fetch("runs", [])

duplicate_ids(needs).each { |id| errors << "registry/needs.yaml: duplicate need id #{id}" }
duplicate_ids(skills).each { |id| errors << "registry/skills.yaml: duplicate skill id #{id}" }
duplicate_ids(runs).each { |id| errors << "registry/usage.yaml: duplicate run id #{id}" }

need_ids = needs.map { |item| item["id"] }.compact.to_set
audience_ids = audiences.map { |item| item["id"] }.compact.to_set
skill_by_id = skills.to_h { |item| [item["id"], item] }

packs = {}
Dir[ROOT.join("packs/*/PACK.yaml")].sort.each do |raw_path|
  path = Pathname.new(raw_path)
  data = load_yaml(path, errors)
  folder = path.parent.basename.to_s
  errors << "#{path.relative_path_from(ROOT)}: id must match folder #{folder}" unless data["id"] == folder
  errors << "#{path.relative_path_from(ROOT)}: duplicate pack id #{data['id']}" if packs.key?(data["id"])
  packs[data["id"]] = data
end

pack_ids = packs.keys.to_set
pack_skill_ids = packs.values.flat_map { |pack| pack.fetch("skills", []) }.to_set

agents = {}
Dir[ROOT.join("agents/**/AGENT.md")].sort.each do |raw_path|
  path = Pathname.new(raw_path)
  relative_parent = path.parent.relative_path_from(ROOT.join("agents")).to_s
  data, = frontmatter(path, errors)
  metadata = data.fetch("metadata", {})
  expected_name = path.parent.basename.to_s

  errors << "#{path.relative_path_from(ROOT)}: name must match folder #{expected_name}" unless data["name"] == expected_name
  errors << "#{path.relative_path_from(ROOT)}: metadata.kind must be agent-blueprint" unless metadata["kind"] == "agent-blueprint"
  unless ALLOWED_AGENT_STATUSES.include?(metadata["status"])
    errors << "#{path.relative_path_from(ROOT)}: invalid agent status #{metadata['status'].inspect}"
  end
  agents[relative_parent] = data
end

actual_skill_ids = Set.new
Dir[ROOT.join("skills/*/*/SKILL.md")].sort.each do |raw_path|
  path = Pathname.new(raw_path)
  skill_root = path.parent
  skill_id = skill_root.relative_path_from(ROOT.join("skills")).to_s
  actual_skill_ids << skill_id

  data, text = frontmatter(path, errors)
  expected_name = skill_root.basename.to_s
  errors << "#{path.relative_path_from(ROOT)}: name must match folder #{expected_name}" unless data["name"] == expected_name
  if data["description"].to_s.strip.length < 30
    errors << "#{path.relative_path_from(ROOT)}: description is missing or not discriminating"
  end
  errors << "#{path.relative_path_from(ROOT)}: executable skill contains unfinished placeholder text" if text.match?(/\bplaceholder\b/i)

  unless skill_by_id.key?(skill_id)
    errors << "#{path.relative_path_from(ROOT)}: missing registry/skills.yaml entry for #{skill_id}"
  end
end

(skill_by_id.keys.to_set - actual_skill_ids).each do |id|
  errors << "registry/skills.yaml: registered skill #{id} has no SKILL.md"
end

skills.each do |entry|
  id = entry["id"]
  next unless id

  expected_path = "skills/#{id}"
  errors << "registry/skills.yaml: #{id} path must be #{expected_path}" unless entry["path"] == expected_path
  unless ALLOWED_SKILL_STATUSES.include?(entry["status"])
    errors << "registry/skills.yaml: #{id} has invalid status #{entry['status'].inspect}"
  end

  entry.fetch("need_ids", []).each do |need_id|
    errors << "registry/skills.yaml: #{id} references unknown need #{need_id}" unless need_ids.include?(need_id)
  end
  entry.fetch("agents", []).each do |agent_id|
    errors << "registry/skills.yaml: #{id} references unknown agent #{agent_id}" unless agents.key?(agent_id)
  end
  entry.fetch("packs", []).each do |pack_id|
    errors << "registry/skills.yaml: #{id} references unknown pack #{pack_id}" unless pack_ids.include?(pack_id)
    unless packs.fetch(pack_id, {}).fetch("skills", []).include?(id)
      errors << "registry/skills.yaml: #{id} lists pack #{pack_id}, but that pack does not include the skill"
    end
  end

  package_path = ROOT.join(expected_path, "PACKAGE.yaml")
  unless package_path.exist?
    errors << "#{expected_path}: missing PACKAGE.yaml"
    next
  end

  package = load_yaml(package_path, errors)
  errors << "#{package_path.relative_path_from(ROOT)}: id must equal #{id}" unless package["id"] == id
  errors << "#{package_path.relative_path_from(ROOT)}: kind must be skill" unless package["kind"] == "skill"
  errors << "#{package_path.relative_path_from(ROOT)}: status differs from registry" unless package["status"] == entry["status"]
  errors << "#{package_path.relative_path_from(ROOT)}: owner differs from registry" unless package["owner"] == entry["owner"]

  package.fetch("need_ids", []).each do |need_id|
    errors << "#{package_path.relative_path_from(ROOT)}: unknown need #{need_id}" unless need_ids.include?(need_id)
  end
  package.fetch("audiences", []).each do |audience_id|
    errors << "#{package_path.relative_path_from(ROOT)}: unknown audience #{audience_id}" unless audience_ids.include?(audience_id)
  end
  package.fetch("agents", []).each do |agent_id|
    errors << "#{package_path.relative_path_from(ROOT)}: unknown agent #{agent_id}" unless agents.key?(agent_id)
  end

  usage = entry.fetch("usage", {})
  recorded_runs = usage.fetch("controlled_test_runs", 0).to_i + usage.fetch("production_runs", 0).to_i
  if %w[dogfood core].include?(entry["status"]) && recorded_runs < 1
    errors << "registry/skills.yaml: #{id} is #{entry['status']} without a recorded run"
  end
  if %w[dogfood core].include?(entry["status"]) && runs.none? { |run| run["skill"] == id }
    errors << "registry/usage.yaml: #{id} is #{entry['status']} without sanitized run evidence"
  end

  if entry["status"] == "core"
    errors << "registry/skills.yaml: #{id} needs at least 3 production runs for CORE" if usage.fetch("production_runs", 0).to_i < 3
    errors << "registry/skills.yaml: #{id} needs at least 2 distinct projects for CORE" if usage.fetch("distinct_projects", 0).to_i < 2
    unless package.dig("provenance", "public_sanitized") == true
      errors << "#{package_path.relative_path_from(ROOT)}: CORE requires public_sanitized: true"
    end
  end

  review_due = parse_date(entry.dig("review", "review_due"))
  if review_due.nil?
    errors << "registry/skills.yaml: #{id} has no valid review_due date"
  elsif review_due < Date.today
    message = "registry/skills.yaml: #{id} review overdue since #{review_due}"
    STRICT_DATES ? errors << message : warnings << message
  end
end

pack_skill_ids.each do |id|
  errors << "packs: references unknown maintained skill #{id}" unless skill_by_id.key?(id)
end

needs.each do |need|
  need.fetch("audiences", []).each do |audience_id|
    errors << "registry/needs.yaml: #{need['id']} references unknown audience #{audience_id}" unless audience_ids.include?(audience_id)
  end
  need.fetch("resolved_by", []).each do |skill_id|
    errors << "registry/needs.yaml: #{need['id']} resolves to unknown skill #{skill_id}" unless skill_by_id.key?(skill_id)
  end
end

runs.each do |run|
  errors << "registry/usage.yaml: #{run['id']} references unknown skill #{run['skill']}" unless skill_by_id.key?(run["skill"])
end

warnings.each { |message| warn "WARNING: #{message}" }

if errors.any?
  errors.each { |message| warn "ERROR: #{message}" }
  warn "Validation failed with #{errors.length} error(s) and #{warnings.length} warning(s)."
  exit 1
end

puts "Validated #{skills.length} skill(s), #{agents.length} agent(s), #{packs.length} pack(s), #{needs.length} need(s), and #{runs.length} run record(s)."
puts "Warnings: #{warnings.length}"
