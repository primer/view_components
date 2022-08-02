# frozen_string_literal: true

require "thor"
require "active_support/core_ext/string/inflections"

# Migrates components to their new namespace.
#
# Usage:
#
# bundle exec thor component_status_migrator MyComponentName
# bundle exec thor component_status_migrator MyComponentName --status beta
class ComponentStatusMigrator < Thor::Group
  include Thor::Actions

  STATUSES = %w[alpha beta deprecated stable].freeze

  # Define arguments and options
  argument :name
  class_option :status, default: "alpha", desc: "Status of the component. Either alpha, beta, stable or deprecated", required: true, type: :string

  def self.source_root
    File.dirname(__FILE__)
  end

  def validate_status
    raise "Invalid status: #{status}" unless STATUSES.include?(status)
  end

  def move_controller
    move_file("controller", controller_path, controller_path_with_status)
  end

  def move_template
    move_file("template", template_path, template_path_with_status)
  end

  def copy_test
    move_file("test", test_path, test_path_with_status)
  end

  def move_story
    move_file("story", story_path, story_path_with_status)
  end

  def add_module
    if stable?
      puts "No change needed - module #{status.capitalize} not added"
    else
      insert_into_file(controller_path_with_status, "  module #{status.capitalize}\n", after: "module Primer\n")
      insert_into_file(controller_path_with_status, "  end\n", before: /^end$/, force: true)
    end
  end

  def remove_suffix
    if name == name_without_suffix
      puts "No change needed - class suffix not removed"
    else
      gsub_file(controller_path_with_status, "class #{name}", "class #{name_without_suffix}")
    end
  end

  def rename_test_class
    gsub_file(test_path_with_status, /class .*Test </, "class Primer#{status.capitalize}#{name_without_suffix.gsub('::', '')}Test <")
  end

  def add_require_to_story
    require_statement = "require \"primer/#{status_folder_name}#{name_without_suffix.underscore}\"\n"
    insert_into_file(story_path_with_status, require_statement, after: "# frozen_string_literal: true\n")
  end

  def rename_story_class
    prior_class_name = /class Primer::#{name.capitalize}Stories/
    new_class_name = "class Primer::#{name_without_suffix.capitalize}Stories"
    gsub_file(story_path_with_status, prior_class_name, new_class_name)
  end

  def rename_nav_entry
    gsub_file("docs/src/@primer/gatsby-theme-doctocat/nav.yml", "class #{name}", name_without_suffix)
  end

  def update_all_references
    run("grep -rl #{name} . --exclude=CHANGELOG.md --exclude=#{test_path} | xargs sed -i 's/Primer::#{name}/Primer::#{status_module}#{name_without_suffix}/g'")
  end

  def add_alias
    insert_into_file(controller_path_with_status, "\nPrimer::#{name} = Primer::#{status_module}#{name_without_suffix}\n")
  end

  def add_to_linter
    insert_into_file(
      "lib/rubocop/cop/primer/component_name_migration.rb",
      "\"Primer::#{name}\" => \"Primer::#{status_module}#{name_without_suffix}\",\n",
      after: "DEPRECATIONS = {\n"
    )
  end

  def run_rubocop
    run("bundle exec rubocop -a")
  end

  def generate_docs
    run("bundle exec rake docs:build")
  end

  def dump_static_files
    run("bundle exec rake static:dump")
  end

  private

  def controller_path
    "app/components/primer/#{name.underscore}.rb"
  end

  def controller_path_with_status
    "app/components/primer/#{status_folder_name}#{name_without_suffix.underscore}.rb"
  end

  def move_file(file_type, old_path, new_path)
    if old_path == new_path
      puts "No change needed - #{file_type} file not moved"
    elsif File.exist?(old_path)
      copy_file(old_path, new_path)
      remove_file(old_path)
    else
      puts "Nothing moved. #{file_type.capitalize} file not found: #{story_path}"
    end
  end

  def stable?
    status == "stable"
  end

  def status_folder_name
    "#{status}/" unless stable?
  end

  def status_module
    "#{status.capitalize}::" unless stable?
  end

  def template_path
    "app/components/primer/#{name.underscore}.html.erb"
  end

  def template_path_with_status
    "app/components/primer/#{status_folder_name}#{name_without_suffix.underscore}.html.erb"
  end

  def test_path
    "test/components/#{name.underscore}_test.rb"
  end

  def test_path_with_status
    "test/components/#{status_folder_name}#{name_without_suffix.underscore}_test.rb"
  end

  def story_path
    "stories/primer/#{name.underscore}_stories.rb"
  end

  def story_path_with_status
    "stories/primer/#{status_folder_name}#{name_without_suffix.underscore}_stories.rb"
  end

  def docs_path
    "/components/#{short_name}.md"
  end

  def docs_path_with_status
    "/components/#{status_folder_name}#{short_name}.md"
  end

  def status
    options[:status].downcase
  end

  def name_without_suffix
    name.gsub("Component", "")
  end

  def short_name
    name_with_status = name.gsub(/Primer::|Component/, "")

    m = name_with_status.match(/(?<status>Beta|Alpha|Deprecated)?(?<_colons>::)?(?<name>.*)/)
    m[:name].gsub("::", "").downcase
  end
end
