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

  def self.exit_on_failure?
    true
  end

  def validate_status
    raise "Invalid status: #{status}" unless STATUSES.include?(status)
  end

  def move_controller
    move_file(
      "controller",
      old_version.controller_path,
      new_version.controller_path,
    )
  end

  def move_template
    if File.exist?(old_version.template_path)
      move_file(
        "template",
        old_version.template_path,
        new_version.template_path,
      )
    end
  end

  def update_css
    gsub_file(primer_css_file, component_css_import, component_css_import_with_status)
  end

  def move_test
    if File.exist?(old_version.test_path)
      move_file(
        "test",
        old_version.test_path,
        new_version.test_path,
      )
    end
  end

  def move_preview
    if File.exist?(old_version.preview_path)
      move_file(
        "preview",
        old_version.preview_path,
        new_version.preview_path,
      )
    end
  end

  def add_module_to_component
    # TODO avoid adding the module twice
    if !stable?
      insert_into_file(new_version.controller_path, "  module #{class_status}\n", after: "module Primer\n")
      insert_into_file(new_version.controller_path, "  end\n", before: /^end$/, force: true)
    end
  end

  def add_module_to_preview
    return if stable?
    return nil unless File.exist?(new_version.preview_path)

    insert_into_file(new_version.preview_path, "  module #{class_status}\n", after: "module Primer\n")
    insert_into_file(new_version.preview_path, "  end\n", before: /^end$/, force: true)
  end

  def remove_suffix_from_component_class
    if name == name_without_suffix
      puts "No change needed - component suffix not removed from component class name"
    else
      gsub_file(new_version.controller_path, "class #{name}", "class #{name_without_suffix}")
    end
  end

  def remove_suffix_from_preview_class
    return nil unless File.exist?(new_version.preview_path)

    original_preview_class = /class .*Preview < ViewComponent::Preview/
    updated_preview_class = "class #{name_without_suffix}Preview < ViewComponent::Preview"
    gsub_file(new_version.preview_path, original_preview_class, updated_preview_class)
  end

  def rename_preview_label
    return nil unless File.exist?(new_version.preview_path)

    gsub_file(new_version.preview_path, /# @label #{name}/, "# @label #{name_without_suffix}")
  end

  def rename_test_class
    return nil unless File.exist?(new_version.test_path)

    gsub_file(
      new_version.test_path,
      /class .*Test </,
      "class Primer#{class_status}#{name_without_suffix.gsub('::', '')}Test <",
    )
  end

  def rename_nav_entry
    nav_file = "docs/src/@primer/gatsby-theme-doctocat/nav.yml"
    gsub_file(nav_file, "title: #{name}", "title: #{name_without_suffix}")
    gsub_file(nav_file, "url: \"/components/#{name_without_suffix.downcase}\"", "url: \"/components/#{status_url}#{name_without_suffix.downcase}\"")
  end

  def update_primer_js_imports
    primer_js = "app/components/primer/primer.ts"
    original_content = "import './#{name.underscore}'"
    updated_content = "import './#{status_folder_name}#{name_without_suffix.underscore}'"
    gsub_file(primer_js, original_content, updated_content)
  end

  def update_all_references
    exclude_files = [
      ".overmind.sock",
      "CHANGELOG.md",
      old_version.test_path
    ]

    exclude_folders = [
      ".git",
      ".cache",
      ".yardoc",
      "builds",
      "log",
      "node_modules",
      "tmp",
      "vendor"
    ]

    cmd = ["grep -rl #{name} ."]
    cmd << exclude_files.map { |f| "--exclude=#{f}" }.join(" ")
    cmd << "--exclude-dir={#{exclude_folders.join(',')}}"
    cmd << "| xargs sed -i '' 's/Primer::#{name}/Primer::#{status_module}#{name_without_suffix}/g'"

    run(cmd.join(" "))
  end

  def add_alias
    return if old_version.controller_path == new_version.controller_path

    remove_file(old_version.controller_path)
    create_file(
      old_version.controller_path,
      "# frozen_string_literal: true\n\nmodule Primer\n\tclass #{name} < Primer::#{status_module}#{name_without_suffix}\n\t\tstatus :deprecated\n\tend\nend"
    )
  end

  def add_to_deprecated_component_configuration
    content = []
    content << "  - component: \"Primer::#{name}\"\n"
    content << "    replacement: \"Primer::#{status_module}#{name_without_suffix}\"\n"

    insert_into_file(
      "lib/primer/deprecations.yml",
      content.join,
      after: "deprecations:\n"
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
    # IMPORTANT: the `exit 0` must be here because
    # rubocop will exit with a non-zero code, due to
    # the expected linter failures. this causes thor
    # to stop running the script before it should
    run("bundle exec rubocop -a; exit 0")
  end

  def generate_docs
    run("bundle exec rake docs:build")
  end

  def dump_static_files
    run("bundle exec rake static:dump")
  end

  def show_instructions
    puts ""
    puts "Component Status Migration Completed"
    puts "------------------------------------"
    puts ""
    puts "Original Component: 'Primer::#{name}'"
    puts "     New Component: 'Primer::#{status_module}#{name_without_suffix}'"
    puts ""
    puts "IMPORTANT NOTE:"
    puts ""
    puts "The original component has been marked as deprecated, but needs additional configuration. Please update the entry in 'lib/primer/deprecations.yml'."
    puts ""
  end

  private

  def new_version
    @new_version ||= ComponentVersion.new(name.gsub("Component", ""), status)
  end

  def old_version
    @old_version ||= ComponentVersion.new(name)
  end

  def class_status
    @class_status ||= status.capitalize unless stable?
  end

  def component_css_import
    # TODO use relative location
    @component_css_import ||= "import \"./#{name.underscore}.pcss\""
  end

  def component_css_import_with_status
    # TODO use relative location
    @component_css_import_with_status ||= "import \"./#{status_folder_name}#{name_without_suffix.underscore}.pcss\""
  end

  def move_file(file_type, old_path, new_path)
    if old_path == new_path
      puts "No change needed - #{file_type} file not moved"
    elsif File.exist?(old_path)
      copy_file(old_path, new_path)
      remove_file(old_path)
    else
      puts "Nothing moved. #{file_type.capitalize} file not found: #{old_path}"
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

  def status
    @status ||= options[:status].downcase
  end

  def status_url
    @status_url ||= "#{status}/" unless stable?
  end

  def name_without_suffix
    @name_without_suffix ||= name.gsub("Component", "")
  end

  def primer_css_file
    "app/components/primer/primer.pcss"
  end

  def short_name
    @short_name ||= begin
      name_with_status = name.gsub(/Primer::|Component/, "")
      m = name_with_status.match(/(?<status>Beta|Alpha|Deprecated)?(?<_colons>::)?(?<name>.*)/)
      m[:name].gsub("::", "").downcase
    end
  end
end

class ComponentVersion
  COMPONENT_PATH = File.join("app", "components", "primer")

  attr_reader :name, :status

  def initialize(name, status = nil)
    @name = name
    @status = (status || inferred_status).to_sym
  end

  def controller_path
    File.join(base_path, component_file_name)
  end

  def template_path
    File.join(base_path, "#{ name.underscore }.html.erb")
  end

  def test_path
    File.join("test", "components", status_directory, "#{ name.underscore }_test.rb")
  end

  def preview_path
    preview_directory = File.join("previews", "primer", status_directory)
    path_with_component = File.join(preview_directory, "#{ name.underscore }_component_preview.rb")

    if File.exist?(path_with_component)
      path_with_component
    else
      path_with_component = File.join(preview_directory, "#{ name.underscore }_preview.rb")
    end
  end

  private

  def inferred_status
    component_paths = Dir.glob(File.join(COMPONENT_PATH, "**", component_file_name))

    if component_paths.empty?
      raise("Couldn't find #{ component_file_name } in component directory")
    end

    if component_paths.size > 1
      raise("Found multiple files named #{ component_file_name } in component directory, can't infer version")
    end

    component_path = component_paths.first
    component_directory = File.dirname(component_path)

    if component_directory != COMPONENT_PATH
      File.split(component_directory).last.to_sym
    else
      content = File.read(component_path)

      if content =~ /^\s+status\s+:stable\s*$/
        :stable
      elsif content =~ /^\s+status\s+:deprecated\s*$/
        :deprecated
      else
        raise("Can't infer version of #{ component_path }")
      end
    end
  end

  def status_directory
    if [:deprecated, :stable].include?(status)
      ""
    else
      status.to_s
    end
  end

  def base_path
    File.join(COMPONENT_PATH, status_directory)
  end

  def component_file_name
    "#{ name.underscore }.rb"
  end
end
