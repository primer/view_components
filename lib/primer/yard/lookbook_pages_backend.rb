# frozen_string_literal: true

require "primer/yard/component_manifest"

module Primer
  module YARD
    class LookbookPagesBackend
      attr_reader :registry

      def initialize(registry)
        @registry = registry
      end

      def generate
        each_component do |component|
          generate_component_docs(component)
        end
      end

      private

      def generate_component_docs(component)
        docs = registry.find(component)
        path = File.join(*%w(demo test components docs forms inputs), "#{docs.short_name}.md.erb")

        File.open(path, "w") do |f|
          f.write <<~END
            ---
            title: #{docs.title}
            ---

            #{docs.base_docstring}
          END
        end
      end

      def each_component(&block)
        manifest.form_components.each(&block)
      end

      def manifest
        Primer::YARD::ComponentManifest
      end
    end
  end
end
