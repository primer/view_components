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

  def check_current_status
    from_version = ComponentVersion.new(name)

    p from_version.name
    p from_version.status
    p from_version.path

    exit
  end

  def move_controller
    move_file("controller", controller_path, controller_path_with_status)
  end

  def move_template
    return nil unless File.exist?(template_path)

    move_file("template", template_path, template_path_with_status)
  end

  def update_css
    gsub_file(primer_css_file, component_css_import, component_css_import_with_status)
  end

  def move_test
    return nil unless File.exist?(test_path)

    move_file("test", test_path, test_path_with_status)
  end

  def move_preview
    return nil unless File.exist?(preview_path)

    move_file("preview", preview_path, preview_path_with_status)
  end

  def add_module_to_component
    return if stable?

    insert_into_file(controller_path_with_status, "  module #{class_status}\n", after: "module Primer\n")
    insert_into_file(controller_path_with_status, "  end\n", before: /^end$/, force: true)
  end

  def add_module_to_preview
    return if stable?
    return nil unless File.exist?(preview_path_with_status)

    insert_into_file(preview_path_with_status, "  module #{class_status}\n", after: "module Primer\n")
    insert_into_file(preview_path_with_status, "  end\n", before: /^end$/, force: true)
  end

  def remove_suffix_from_component_class
    if name == name_without_suffix
      puts "No change needed - component suffix not removed from component class name"
    else
      gsub_file(controller_path_with_status, "class #{name}", "class #{name_without_suffix}")
    end
  end

  def remove_suffix_from_preview_class
    return nil unless File.exist?(preview_path_with_status)

    original_preview_class = /class .*Preview < ViewComponent::Preview/
    updated_preview_class = "class #{name_without_suffix}Preview < ViewComponent::Preview"
    gsub_file(preview_path_with_status, original_preview_class, updated_preview_class)
  end

  def rename_preview_label
    return nil unless File.exist?(preview_path_with_status)

    gsub_file(preview_path_with_status, /# @label #{name}/, "# @label #{name_without_suffix}")
  end

  def rename_test_class
    return nil unless File.exist?(test_path_with_status)

    gsub_file(test_path_with_status, /class .*Test </, "class Primer#{class_status}#{name_without_suffix.gsub('::', '')}Test <")
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
      test_path
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
    return if controller_path == controller_path_with_status

    remove_file(controller_path)
    create_file(
      controller_path,
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

  def class_status
    @class_status ||= status.capitalize unless stable?
  end

  def controller_path
    @controller_path ||= "app/components/primer/#{name.underscore}.rb"
  end

  def controller_path_with_status
    @controller_path_with_status ||= "app/components/primer/#{status_folder_name}#{name_without_suffix.underscore}.rb"
  end

  def component_css_import
    @component_css_import ||= "import \"./#{name.underscore}.pcss\""
  end

  def component_css_import_with_status
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

  def preview_path
    @preview_path ||= begin
      path = "previews/primer/#{name.underscore}_preview.rb"
      path_with_component = "previews/primer/#{name.underscore}_component_preview.rb"
      File.exist?(path_with_component) ? path_with_component : path
    end
  end

  def preview_path_with_status
    @preview_path_with_status ||= "previews/primer/#{status_folder_name}#{name_without_suffix.underscore}_preview.rb"
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

  def status_full_path
    @status_full_path ||= "app/components/primer/#{status_folder_name}"
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

  def docs_path
    @docs_path ||= "/components/#{short_name}.md"
  end

  def docs_path_with_status
    @docs_path_with_status ||= "/components/#{status_folder_name}#{short_name}.md"
  end

  def status
    @status ||= options[:status].downcase
  end

  def from_status
    @detected_status ||= STATUSES.detect { |from_status|
      controller_path = File.join(
        source_path_for_status(from_status),
        "#{name.underscore}.rb",
      )

      File.exists?(controller_path)
    }

    @detected_status || raise("Couldn't find #{name.underscore}.rb in component directory")
  end

  def source_path_for_status(from_status)
    if from_status == "deprecated"
      File.join("app", "components", "primer")
    else
      File.join("app", "components", "primer", from_status)
    end
  end

  def status_url
    @status_url ||= "#{status}/" unless stable?
  end

  def name_without_suffix
    @name_without_suffix ||= name.gsub("Component", "")
  end

  def primer_css_file
    @primer_css_file ||= "app/components/primer/primer.pcss"
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

  def path
    if [:deprecated, :stable].include?(status)
      COMPONENT_PATH
    else
      File.join(COMPONENT_PATH, status.to_s)
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

  def component_file_name
    "#{ name.underscore }.rb"
  end
end
