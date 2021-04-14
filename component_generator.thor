# frozen_string_literal: true

require 'thor'
require 'active_support/core_ext/string/inflections'

class ComponentGenerator < Thor::Group
  include Thor::Actions

  # Define arguments and options
  argument :name
  class_option :js, default: nil

  def self.source_root
    File.dirname(__FILE__)
  end

  def create_controller
    template('templates/component.tt', "app/components/primer/#{underscore_name}.rb")
  end

  def create_template
    template('templates/component.html.tt', "app/components/primer/#{underscore_name}.html.erb")
  end

  def create_test
    template('templates/test.tt', "test/components/#{underscore_name}_test.rb")
  end

  def create_stories
    template('templates/stories.tt', "stories/primer/#{underscore_name}_stories.rb")
  end

  def add_to_rakefile
    insert_into_file "Rakefile", "      Primer::#{class_name},\n", after: "    components = [\n"

    return unless js_package_name
    insert_into_file "Rakefile", "      Primer::#{class_name},\n", after: "js_components = [\n", force: true
  end

  def create_ts_file
    return unless js_package_name
    template('templates/component.ts.tt', "app/components/primer/#{underscore_name}.ts")
  end

  def import_in_primer_ts
    return unless js_package_name
    append_to_file("app/components/primer/primer.ts", "import './#{underscore_name}'")
  end

  def install_js_package
    return unless js_package_name
    run "yarn add #{js_package_name}"
  end

  private

  def class_name
    name.camelize
  end

  def underscore_name
    name.underscore
  end

  def js_package_name
    options[:js]
  end
end
