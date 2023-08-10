# frozen_string_literal: true

require "thor"
require "active_support/core_ext/string/inflections"
require "primer/view_components/constants"

# Generates component adding them to the necessary files.
#
# Usage:
#
# bundle exec thor linter_generator Primer::Beta::Breadcrumbs
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

  def ask_required_arguments
    @required_arguments = ask("Does the component have any required arguments? (separated by spaces if more than one):")
  end

  def ask_classes
    @classes = ask("Enter the default classes for the component (separated by spaces if more than one):")
  end

  def create_linter
    template("templates/linter.tt", linter_path)
  end

  def create_linter_test
    template("templates/linter_test.tt", linter_test_path)
  end

  def create_argument_mapper
    return unless @autocorrectable

    template("templates/argument_mapper.tt", mapper_path)
  end

  def create_argument_mapper_test
    return unless @autocorrectable

    template("templates/argument_mapper_test.tt", argument_mapper_test_path)
  end

  def run_rubocop
    run "bundle exec rubocop -a #{linter_path} #{linter_test_path} #{mapper_path if @autocorrectable} #{argument_mapper_test_path if @autocorrectable}"
  end

  private

  def linter_path
    "lib/primer/view_components/linters/#{component_short_name.underscore}_component_migration_counter.rb"
  end

  def linter_test_path
    "test/lib/erblint/#{component_short_name.underscore}_component_migration_counter_test.rb"
  end

  def mapper_path
    "lib/primer/view_components/linters/argument_mappers/#{component_short_name.underscore}.rb"
  end

  def argument_mapper_test_path
    "test/lib/erblint/argument_mappers/#{component_short_name.underscore}_test.rb"
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

  def component_full_name
    return name if name.start_with?("Primer::")

    "Primer::#{name}"
  end

  def default_tag
    return @tag unless @tags_from_constant

    Primer::ViewComponents::Constants.get(
      component: component_full_name,
      constant: "DEFAULT_TAG"
    )
  end
end
