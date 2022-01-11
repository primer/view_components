# frozen_string_literal: true

require "thor"
require "active_support/core_ext/string/inflections"

# Generates component adding them to the necessary files.
#
# Usage:
#
# bundle exec thor component_generator my_component_name
# bundle exec thor component_generator my_component_name --js some-npm-package
# bundle exec thor component_generator my_component_name --status beta
class ComponentGenerator < Thor::Group
  include Thor::Actions

  # Define arguments and options
  argument :name
  class_option :status, default: "alpha", desc: "Status of the component. One of alpha, beta or stable"
  class_option :js, default: nil, desc: "Name of the package to import for this component."
  class_option :inline, type: :boolean, desc: "Use this option to create a #call method instead of generating an ERB template for the component."

  def self.source_root
    File.dirname(__FILE__)
  end

  def create_controller
    template("templates/#{status_template_path}/component.tt", "app/components/primer/#{status_path}#{underscore_name}.rb")
  end

  def create_template
    template("templates/component.html.tt", "app/components/primer/#{status_path}#{underscore_name}.html.erb") unless inline?
  end

  def create_test
    template("templates/test.tt", "test/components/primer/#{status_path}#{underscore_name}_test.rb")
  end

  def create_system_test
    template("templates/system_test.rb.tt", "test/system/#{status_path}#{underscore_name}_test.rb") if js_package_name
    template("templates/#{status_template_path}system_test_preview.rb.tt", "demo/test/components/previews/primer/#{status_path}#{underscore_name}_preview.rb") if js_package_name
  end

  def create_stories
    template("templates/stories.tt", "stories/primer/#{status_path}#{underscore_name}_stories.rb")
  end

  def add_to_docs_rakefile
    insert_into_file("lib/tasks/docs.rake", "      Primer::#{status_module}#{class_name},\n", after: "    components = [\n")
    insert_into_file("lib/tasks/docs.rake", "      Primer::#{status_module}#{class_name},\n", after: "js_components = [\n", force: true) if js_package_name
  end

  def add_to_component_test
    insert_into_file("test/components/component_test.rb", "    [Primer::#{status_module}#{class_name}, {}],\n", after: "COMPONENTS_WITH_ARGS = [\n")
  end

  def add_to_nav
    append_to_file("docs/src/@primer/gatsby-theme-doctocat/nav.yml") do
      <<-HEREDOC
    - title: #{class_name} - Fix my order in docs/src/@primer/gatsby-theme-doctocat/nav.yml
      url: /components/#{short_name}
      HEREDOC
    end
  end

  def create_ts_file
    template("templates/component.ts.tt", "app/components/primer/#{status_path}#{underscore_name}.ts") if js_package_name
  end

  def import_in_primer_ts
    append_to_file("app/components/primer/primer.ts", "import './#{status_path}#{underscore_name}'\n") if js_package_name
  end

  def install_js_package
    run "yarn add #{js_package_name}" if js_package_name
  end

  private

  def status_path
    return if status == "stable"

    "#{status}/"
  end

  def status_module
    return if status == "stable"

    "#{status.camelize}::"
  end

  def status_template_path
    return unless status == "stable"

    "stable/"
  end

  def module_name
    return if status == "stable"

    status.camelize
  end

  def class_name
    name.camelize
  end

  def underscore_name
    name.underscore
  end

  def custom_element_name
    underscore_name.tr("_", "-")
  end

  def short_name
    class_name.gsub(/Primer|::|Component/, "").downcase
  end

  def js_package_name
    options[:js]
  end

  def inline?
    options[:inline]
  end

  def status
    options[:status]
  end
end
