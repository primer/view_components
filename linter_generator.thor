# frozen_string_literal: true

require "thor"
require "active_support/core_ext/string/inflections"

# Generates component adding them to the necessary files.
#
# Usage:
#
# bundle exec thor linter_generator my_component_name
class LinterGenerator < Thor::Group
  include Thor::Actions

  # Define arguments and options
  argument :name

  def self.source_root
    File.dirname(__FILE__)
  end

  def ask_autocorrectable
    @autocorrectable = yes?("Is the linter autocorrectable? (y/N)")
  end

  def ask_tags
    if yes?("Does the component accept multiple tags? (y/N)")
      @tags_from_constant = true
    else
      @tag = ask("Enter the tag name:")
    end
  end

  def ask_classes
    @classes = ask("Enter the default classes for the component (separated by spaces if more than one):")
  end

  def create_linter
    template("templates/linter.tt", linter_path)
  end

  def run_rubocop
    run "bundle exec rubocop -a #{linter_path}"
  end

  private

  def linter_path
    "lib/primer/view_components/linters/#{component_short_name.underscore}_component_migration_counter.rb"
  end

  def status_module_and_short_name
    name_with_status = name.gsub(/Primer::|Component/, "")

    m = name_with_status.match(/(?<status>Beta|Alpha|Deprecated)?(?<_colons>::)?(?<name>.*)/)
    [m[:status]&.downcase, m[:name].gsub("::", "")]
  end

  def component_short_name
    return @component_short_name if defined?(@component_short_name)

    (_, @component_short_name) = status_module_and_short_name
    @component_short_name
  end

  def component_docs_path
    (status_module, short_name) = status_module_and_short_name
    status_path = status_module.nil? ? "" : "#{status_module}/"

    "https://primer.style/view-components/components/#{status_path}#{short_name.downcase}"
  end

  def component_full_name
    return name if name.start_with?("Primer::")

    "Primer::#{name}"
  end
end
