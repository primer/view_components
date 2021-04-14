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

  def create_lib_file
    template('templates/component.tt', "app/components/primer/#{name.underscore}.rb")
  end

  private

  def class_name
    name.camelize
  end
end
