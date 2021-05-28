# frozen_string_literal: true

require File.expand_path("./../../demo/config/environment.rb", __dir__)
require "primer/view_components"
require "yard"
require "yard/docs_helper"
require "view_component/test_helpers"
Dir["./app/components/primer/**/*.rb"].sort.each { |file| require file }

module YARD
  # Generate ViewComponent previews from yard examples
  class DocsPreviewGenerator
    include ViewComponent::TestHelpers
    include Primer::ViewHelper
    include YARD::DocsHelper

    def self.call
      registry = YARD::RegistryStore.new
      registry.load!(".yardoc")

      components = Primer::Component.descendants

      # Generate previews from documentation examples
      components.each do |component|
        documentation = registry.get(component.name)
        short_name = component.name.gsub(/Primer|::/, "")
        initialize_method = documentation.meths.find(&:constructor?)

        next unless initialize_method.tags(:example).any?

        yard_example_tags = initialize_method.tags(:example)

        path = Pathname.new("demo/test/components/previews/primer/docs/#{short_name.underscore}_preview.rb")
        path.dirname.mkdir unless path.dirname.exist?

        File.open(path, "w") do |f|
          f.puts("module Primer")
          f.puts("  module Docs")
          f.puts("    class #{short_name}Preview < ViewComponent::Preview")

          yard_example_tags.each_with_index do |tag, index|
            method_name = tag.name.split("|").first.downcase.parameterize.underscore
            f.puts("      def #{method_name}; end")
            f.puts unless index == yard_example_tags.size - 1
            path = Pathname.new("demo/test/components/previews/primer/docs/#{short_name.underscore}_preview/#{method_name}.html.erb")
            path.dirname.mkdir unless path.dirname.exist?
            File.open(path, "w") do |view_file|
              view_file.puts(tag.text.to_s)
            end
          end

          f.puts("    end")
          f.puts("  end")
          f.puts("end")
        end
      end
    end
  end
end
