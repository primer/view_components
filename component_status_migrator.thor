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

  STATUSES = %w[alpha beta deprecated stable experimental].freeze

  # Define arguments and options
  argument :name
  class_option :status, default: "alpha", desc: "Status of the component. Valid values: #{STATUSES.join(', ')}", required: true, type: :string

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
    return if stable?

    insert_into_file(controller_path_with_status, "  module #{class_status}\n", after: "module Primer\n")
    insert_into_file(controller_path_with_status, "  end\n", before: /^end$/, force: true)
  end

  def remove_suffix
    if name == name_without_suffix
      puts "No change needed - class suffix not removed"
    else
      gsub_file(controller_path_with_status, "class #{name}", "class #{name_without_suffix}")
    end
  end

  def rename_test_class
    gsub_file(test_path_with_status, /class .*Test </, "class Primer#{class_status}#{name_without_suffix.gsub('::', '')}Test <")
  end

  def add_require_to_story
    require_statement = "require \"primer/#{status_folder_name}#{name_without_suffix.underscore}\"\n"
    insert_into_file(story_path_with_status, require_statement, after: "# frozen_string_literal: true\n")
  end

  def rename_story_class
    new_class_name = "class Primer::#{status_module}#{name_without_suffix}Stories"
    gsub_file(story_path_with_status, /class Primer::#{name}Stories/, new_class_name)
  end

  def rename_nav_entry
    nav_file = "docs/src/@primer/gatsby-theme-doctocat/nav.yml"
    gsub_file(nav_file, "title: #{name}", "title: #{name_without_suffix}")
    gsub_file(nav_file, "url: \"/components/#{name_without_suffix.downcase}\"", "url: \"/components/#{status_url}#{name_without_suffix.downcase}\"")
  end

  def update_all_references
    exclude_files = [
      ".git",
      "CHANGELOG.md",
      test_path
    ]

    exclude_folders = [
      ".cache",
      ".yardoc",
      "builds",
      "log",
      "node_modules",
      "tmp",
      "vendor"
    ]

    cmd = ["grep -rl #{name} ."]
    cmd << exclude_files.join(" --exclude=")
    cmd << "--exclude-dir={#{exclude_folders.join(',')}}"
    cmd << "| xargs sed -i '' 's/Primer::#{name}/Primer::#{status_module}#{name_without_suffix}/g'"

    run(cmd.join(" "))
  end

  def add_alias
    return if controller_path == controller_path_with_status

    remove_file(controller_path)
    create_file(
      controller_path,
      "# frozen_string_literal: true\n\nmodule Primer\n\tclass #{name} < Primer::#{status_module}#{name_without_suffix}\n\t\tstatus :deprecated\n\tend\nend"
    )
  end

  def add_to_deprecated_component_helper
    insert_into_file(
      "lib/primer/deprecations.rb",
      "\"Primer::#{name}\" => \"Primer::#{status_module}#{name_without_suffix}\",\n",
      after: "DEPRECATED_COMPONENTS = {\n"
    )
  end

  def add_to_ignored_component_test
    insert_into_file(
      "test/components/component_test.rb",
      "\"Primer::#{name}\",\n",
      after: "ignored_components = [\n"
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

  def class_status
    @class_status ||= status.capitalize unless stable?
  end

  def controller_path
    @controller_path ||= "app/components/primer/#{name.underscore}.rb"
  end

  def controller_path_with_status
    @controller_path_with_status ||= "app/components/primer/#{status_folder_name}#{name_without_suffix.underscore}.rb"
  end

  def move_file(file_type, old_path, new_path)
    if old_path == new_path
      puts "No change needed - #{file_type} file not moved"
    elsif File.exist?(old_path)
      copy_file(old_path, new_path)
      remove_file(old_path)
    else
      puts "Nothing moved. #{file_type.capitalize} file not found: #{new_path}"
    end
  end

  def stable?
    @stable ||= status == "stable"
  end

  def status_folder_name
    @status_folder_name ||= "#{status}/" unless stable?
  end

  def status_module
    @status_module ||= "#{class_status}::" unless stable?
  end

  def template_path
    @template_path ||= "app/components/primer/#{name.underscore}.html.erb"
  end

  def template_path_with_status
    @template_path_with_status ||= "app/components/primer/#{status_folder_name}#{name_without_suffix.underscore}.html.erb"
  end

  def test_path
    @test_path ||= "test/components/#{name.underscore}_test.rb"
  end

  def test_path_with_status
    @test_path_with_status ||= "test/components/#{status_folder_name}#{name_without_suffix.underscore}_test.rb"
  end

  def story_path
    @story_path ||= "stories/primer/#{name.underscore}_stories.rb"
  end

  def story_path_with_status
    @story_path_with_status ||= "stories/primer/#{status_folder_name}#{name_without_suffix.underscore}_stories.rb"
  end

  def docs_path
    @docs_path ||= "/components/#{short_name}.md"
  end

  def docs_path_with_status
    @docs_path_with_status ||= "/components/#{status_folder_name}#{short_name}.md"
  end

  def status
    @status ||= options[:status].downcase
  end

  def status_url
    @status_url ||= "#{status}/" unless stable?
  end

  def name_without_suffix
    @name_without_suffix ||= name.gsub("Component", "")
  end

  def short_name
    @short_name ||= begin
      name_with_status = name.gsub(/Primer::|Component/, "")
      m = name_with_status.match(/(?<status>Beta|Alpha|Deprecated)?(?<_colons>::)?(?<name>.*)/)
      m[:name].gsub("::", "").downcase
    end
  end
end
