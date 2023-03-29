# frozen_string_literal: true

require "thor"

# :nodoc:
class ComponentVersion
  COMPONENT_PATH = File.join("app", "components", "primer")
  STATUSES = [:stable, :beta, :alpha, :deprecated, :experimental].freeze

  attr_reader :name, :status

  def initialize(name, status = nil)
    @name = name
    @status = status || inferred_component_status

    raise "Invalid status: #{@status}" unless STATUSES.include?(@status)
  end

  def module_name
    status.to_s.capitalize if component_belongs_in_module?
  end

  def fully_qualified_class_name
    "Primer::#{qualified_class_name}"
  end

  def qualified_class_name
    if component_belongs_in_module?
      "#{module_name}::#{name}"
    else
      name.to_s
    end
  end

  def component_belongs_in_module?
    ![:deprecated, :stable].include?(status) # rubocop:disable Rails/NegateInclude
  end

  def controller_path
    File.join(base_path, component_file_name)
  end

  def base_path
    File.join(COMPONENT_PATH, status_directory)
  end

  def static_asset_paths
    Dir.glob(File.join(base_path, "#{name.underscore}.*"))
  end

  def template_path
    File.join(base_path, "#{name.underscore}.html.erb")
  end

  def test_path
    File.join("test", "components", status_directory, "#{name.underscore}_test.rb")
  end

  def preview_path
    preview_directory = File.join("previews", "primer", status_directory)
    path_with_component = File.join(preview_directory, "#{name.underscore}_component_preview.rb")

    if File.exist?(path_with_component)
      path_with_component
    else
      File.join(preview_directory, "#{name.underscore}_preview.rb")
    end
  end

  def css_import_path
    File.join(".", status_directory, "#{name.underscore}.pcss")
  end

  def primer_js_import_path
    File.join(".", status_directory, name.underscore.to_s)
  end

  def status_directory
    if component_belongs_in_module?
      status.to_s
    else
      ""
    end
  end

  private

  def inferred_component_status
    component_paths = Dir.glob(File.join(COMPONENT_PATH, "**", component_file_name))

    raise("Couldn't find #{component_file_name} in component directory") if component_paths.empty?

    if component_paths.size == 1
      inferred_status(component_paths.first)
    else
      active_statuses = component_paths.filter_map do |path|
        status = inferred_status(path)
        status unless status == :deprecated
      end

      if active_statuses.empty?
        :deprecated
      elsif active_statuses.size == 1
        active_statuses.first
      else
        latest_status = STATUSES.detect { |status| active_statuses.include?(status) }
        puts("Found multiple components named #{name} in states #{active_statuses.map(&:to_s).join(', ')}, assuming #{latest_status}")
        latest_status
      end
    end
  end

  def inferred_status(path)
    if defines_status_in_source?(path)
      inferred_status_by_source(path)
    elsif !in_base_directory?(path)
      inferred_status_by_directory(path)
    else
      :deprecated
    end
  end

  def in_base_directory?(path)
    File.dirname(path) == COMPONENT_PATH
  end

  def defines_status_in_source?(path)
    !!status_in_source(path)
  end

  def status_in_source(path)
    content = File.read(path)

    STATUSES.detect do |status|
      status_regex = /^\s+status\s+:#{status}\s*$/
      module_regex = /^\s+module\s+#{status.to_s.capitalize}\s*$/

      status_regex.match?(content) || module_regex.match?(content)
    end
  end

  def inferred_status_by_source(path)
    status_in_source(path) || :deprecated
  end

  def inferred_status_by_directory(path)
    File.split(File.dirname(path)).last.to_sym
  end

  def component_file_name
    "#{name.underscore}.rb"
  end
end

# Migrates components to their new namespace.
#
# Usage:
#
# bundle exec thor component_status_migrator MyComponentName
# bundle exec thor component_status_migrator MyComponentName --status beta
class ComponentStatusMigrator < Thor::Group
  include Thor::Actions

  # Define arguments and options
  argument :name
  class_option(
    :status,
    default: "alpha",
    desc: "Status of the component. Valid values: #{ComponentVersion::STATUSES.join(', ')}",
    required: true,
    type: :string
  )

  def self.source_root
    File.dirname(__FILE__)
  end

  def self.exit_on_failure?
    true
  end

  def verify_different_statuses
    raise "#{old_version.name} is already \"#{old_version.status}\"!" if old_version.status == new_version.status

    puts "Migrating #{old_version.fully_qualified_class_name} -> #{new_version.fully_qualified_class_name}"
  end

  def move_controller
    move_file(
      "controller",
      old_version.controller_path,
      new_version.controller_path
    )
  end

  def move_template
    return unless File.exist?(old_version.template_path)

    move_file(
      "template",
      old_version.template_path,
      new_version.template_path
    )
  end

  def move_assets
    old_version.static_asset_paths.each do |static_asset_path|
      copy_file(
        static_asset_path,
        File.join(new_version.base_path, File.basename(static_asset_path))
      )
      remove_file(static_asset_path)
    end
  end

  def update_css
    gsub_file(
      "app/components/primer/primer.pcss",
      "import \"#{old_version.css_import_path}\"",
      "import \"#{new_version.css_import_path}\""
    )
  end

  def move_test
    return unless File.exist?(old_version.test_path)

    move_file(
      "test",
      old_version.test_path,
      new_version.test_path
    )
  end

  def move_preview
    return unless File.exist?(old_version.preview_path)

    move_file(
      "preview",
      old_version.preview_path,
      new_version.preview_path
    )
  end

  def add_module_to_component
    update_ruby_version_module(new_version.controller_path)
  end

  def add_module_to_preview
    update_ruby_version_module(new_version.preview_path) if File.exist?(new_version.preview_path)
  end

  def remove_suffix_from_component_class
    return if old_version.name == new_version.name

    gsub_file(
      new_version.controller_path,
      "class #{old_version.name}",
      "class #{new_version.name}"
    )
  end

  def remove_suffix_from_preview_class
    return unless File.exist?(new_version.preview_path)

    gsub_file(
      new_version.preview_path,
      /class .*Preview < ViewComponent::Preview/,
      "class #{new_version.name}Preview < ViewComponent::Preview"
    )
  end

  def rename_preview_label
    return unless File.exist?(new_version.preview_path)

    gsub_file(
      new_version.preview_path,
      /# @label #{old_version.name}/,
      "# @label #{new_version.name}"
    )
  end

  def rename_test_class
    return unless File.exist?(new_version.test_path)

    gsub_file(
      new_version.test_path,
      /class .*Test </,
      "class Primer#{new_version.module_name}#{new_version.name.gsub('::', '')}Test <"
    )
  end

  def rename_nav_entry
    nav_file = "docs/src/@primer/gatsby-theme-doctocat/nav.yml"

    gsub_file(
      nav_file,
      "title: #{old_version.name}",
      "title: #{new_version.name}"
    )

    old_path = File.join("/", "components", old_version.status_directory, new_version.name.downcase)
    new_path = File.join("/", "components", new_version.status_directory, new_version.name.downcase)

    gsub_file(
      nav_file,
      "url: \"#{old_path}\"",
      "url: \"#{new_path}\""
    )
  end

  def update_primer_js_imports
    gsub_file(
      "app/components/primer/primer.ts",
      "import '#{old_version.primer_js_import_path}'",
      "import '#{new_version.primer_js_import_path}'"
    )
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
    cmd << "| xargs sed -i '' 's/#{old_version.fully_qualified_class_name}/#{new_version.fully_qualified_class_name}/g'"

    run(cmd.join(" "))
  end

  def add_alias
    return if old_version.controller_path == new_version.controller_path

    remove_file(old_version.controller_path)
    create_file(
      old_version.controller_path,
      <<~DEPRECATED_CLASS
        # frozen_string_literal: true

        module Primer
          class #{old_version.qualified_class_name} < #{new_version.qualified_class_name}
            status :deprecated
          end
        end
      DEPRECATED_CLASS
    )
  end

  def add_to_deprecated_component_configuration
    content = [
      "  - component: \"#{old_version.fully_qualified_class_name}\"\n",
      "    replacement: \"#{new_version.fully_qualified_class_name}\"\n"
    ]

    insert_into_file(
      "lib/primer/deprecations.yml",
      content.join,
      after: "deprecations:\n"
    )
  end

  def add_to_ignored_component_test
    insert_into_file(
      "test/components/component_test.rb",
      "\"#{old_version.fully_qualified_class_name}\",\n",
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
    puts "Original Component: '#{old_version.fully_qualified_class_name}'"
    puts "     New Component: '#{new_version.fully_qualified_class_name}'"
    puts ""
    puts "IMPORTANT NOTE:"
    puts ""
    puts "The original component has been migrated, but may need additional configuration. Please update the entry in 'lib/primer/deprecations.yml'."
    puts ""
  end

  private

  def new_version
    @new_version ||= ComponentVersion.new(
      name.gsub("Component", ""),
      options[:status].downcase.to_sym
    )
  end

  def old_version
    @old_version ||= ComponentVersion.new(name)
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

  def update_ruby_version_module(path)
    if old_version.component_belongs_in_module?
      gsub_file(
        path,
        /^  module #{old_version.module_name}$\n/,
        ""
      )

      gsub_file(
        path,
        "  end\nend\n",
        "end\n"
      )
    end

    return unless new_version.component_belongs_in_module?

    insert_into_file(
      path,
      "  module #{new_version.module_name}\n",
      after: "module Primer\n"
    )

    insert_into_file(
      path,
      "  end\n",
      before: /^end$/,
      force: true
    )
  end
end
