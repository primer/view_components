# frozen_string_literal: true

require 'thor'
require 'active_support/core_ext/string/inflections'

class ComponentGenerator < Thor::Group
  include Thor::Actions

  # Define arguments and options
  argument :name
  # class_option :js, default: nil

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

  private

  def class_name
    name.camelize
  end

  def underscore_name
    name.underscore
  end
end
