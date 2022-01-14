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

  STATUSES = %w[alpha beta deprecated].freeze

  # Define arguments and options
  argument :name
  class_option :status, default: "alpha", desc: "Status of the component. Either alpha, beta or deprecated", required: true, type: :string

  def self.source_root
    File.dirname(__FILE__)
  end

  def validate_status
    raise unless STATUSES.include?(status)
  end

  def move_controller
    raise unless File.exist?(controller_path)

    copy_file(controller_path, controller_path_with_status)
    remove_file(controller_path)

    insert_into_file(controller_path_with_status, "\nPrimer::#{name} = Primer::#{status.capitalize}::#{name_without_suffix}\n")
  end

  def move_template
    if File.exist?(template_path)
      copy_file(template_path, template_path_with_status)
      remove_file(template_path)
    else
      puts "No template found"
    end
  end

  def copy_test
    raise unless File.exist?(test_path)

    copy_file(test_path, test_path_with_status)
  end

  def move_story
    raise unless File.exist?(story_path)

    copy_file(story_path, story_path_with_status)
    remove_file(story_path)
  end

  def add_module
    insert_into_file(controller_path_with_status, "  module #{status.capitalize}\n", after: "module Primer\n")
    insert_into_file(controller_path_with_status, "  end\n", before: /^end$/, force: true)
  end

  def remove_suffix
    gsub_file(controller_path_with_status, "class #{name}", "class #{name_without_suffix}")
  end

  def rename_test_class
    gsub_file(test_path_with_status, /class .*Test/, "class Primer#{name_without_suffix.gsub('::', '')}Test")
  end

  def add_require_to_story
    insert_into_file(story_path_with_status, "require \"primer/#{status}/#{name_without_suffix.underscore}\"\n", after: "# frozen_string_literal: true\n")
  end

  def rename_nav_entry
    gsub_file("docs/src/@primer/gatsby-theme-doctocat/nav.yml", "class #{name}", name_without_suffix)
  end

  def update_all_references
    run("grep -rl #{name} . --exclude=CHANGELOG.md | xargs sed -i 's/Primer::#{name}/Primer::#{status.capitalize}::#{name_without_suffix}/g'")
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
    "app/components/primer/#{status}/#{name_without_suffix.underscore}.rb"
  end

  def template_path
    "app/components/primer/#{name.underscore}.html.erb"
  end

  def template_path_with_status
    "app/components/primer/#{status}/#{name_without_suffix.underscore}.html.erb"
  end

  def test_path
    "test/components/#{name.underscore}_test.rb"
  end

  def test_path_with_status
    "test/components/#{status}/#{name_without_suffix.underscore}_test.rb"
  end

  def story_path
    "stories/primer/#{name.underscore}_stories.rb"
  end

  def story_path_with_status
    "stories/primer/#{status}/#{name_without_suffix.underscore}_stories.rb"
  end

  def docs_path
    "/components/#{short_name}.md"
  end

  def docs_path_with_status
    "/components/#{status}/#{short_name}.md"
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
