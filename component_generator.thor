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
    template('templates/component.tt', "app/components/primer/#{name.underscore}.rb")
  end

  def create_template
    template('templates/component.html.tt', "app/components/primer/#{name.underscore}.html.erb")
  end

  def create_test
    template('templates/test.tt', "test/components/#{name.underscore}_test.rb")
  end

  private

  def class_name
    name.camelize
  end
end
