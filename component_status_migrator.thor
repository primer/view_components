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
    raise unless STATUSES.include?(status)
  end

  def move_controller
    raise unless File.exist?(controller_path)

    if controller_path != controller_path_with_status
      copy_file(controller_path, controller_path_with_status)
      remove_file(controller_path)
    else
      puts "No change needed - controller file not moved"
    end
  end

  def move_template
    if File.exist?(template_path)
      if template_path != template_path_with_status
        copy_file(template_path, template_path_with_status)
        remove_file(template_path)
      else
        puts "No change needed - template file not moved"
      end
    else
      puts "No template found"
    end
  end

  def copy_test
    raise unless File.exist?(test_path)

    if test_path != test_path_with_status
      copy_file(test_path, test_path_with_status)
    else
      puts "No change needed - test file not moved"
    end
  end

  def move_story
    raise unless File.exist?(story_path)

    if story_path != story_path_with_status
      copy_file(story_path, story_path_with_status)
      remove_file(story_path)
    else
      puts "No change needed - story file not moved"
    end
  end

  def add_module
    if !stable?
      insert_into_file(controller_path_with_status, "  module #{status.capitalize}\n", after: "module Primer\n")
      insert_into_file(controller_path_with_status, "  end\n", before: /^end$/, force: true)
    else
      puts "No change needed - module #{status.capitalize} not added"
    end
  end

  def remove_suffix
    if name != name_without_suffix
      gsub_file(controller_path_with_status, "class #{name}", "class #{name_without_suffix}")
    else
      puts "No change needed - class suffix not removed"
    end
  end

  def rename_test_class
    gsub_file(test_path_with_status, /class .*Test </, "class Primer#{status.capitalize}#{name_without_suffix.gsub('::', '')}Test <")
  end

  def add_require_to_story
    insert_into_file(story_path_with_status, "require \"primer/#{status_folder_name}#{name_without_suffix.underscore}\"\n", after: "# frozen_string_literal: true\n")
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
    "app/components/primer/#{name_without_suffix.underscore}.rb"
  end

  def controller_path_with_status
    if stable?
      controller_path
    else
      "app/components/primer/#{status}/#{name_without_suffix.underscore}.rb"
    end
  end

  def stable?
    status == "stable"
  end

  def status_folder_name
    if !stable?
      "#{status}/"
    end
  end

  def status_module
    if !stable?
      "#{status.capitalize}::"
    end
  end

  def template_path
    "app/components/primer/#{name.underscore}.html.erb"
  end

  def template_path_with_status
    if stable?
      template_path
    else
      "app/components/primer/#{status}/#{name_without_suffix.underscore}.html.erb"
    end
  end

  def test_path
    "test/components/#{name.underscore}_test.rb"
  end

  def test_path_with_status
    if stable?
      test_path
    else
      "test/components/#{status}/#{name_without_suffix.underscore}_test.rb"
    end
  end

  def story_path
    "stories/primer/#{name_without_suffix.underscore}_stories.rb"
  end

  def story_path_with_status
    if stable?
      story_path
    else
      "stories/primer/#{status}/#{name_without_suffix.underscore}_stories.rb"
    end
  end

  def docs_path
    "/components/#{short_name}.md"
  end

  def docs_path_with_status
    if stable?
      docs_path
    else
      "/components/#{status}/#{short_name}.md"
    end
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
