# frozen_string_literal: true

require "primer/view_components"
require "primer/yard/docs_helper"
require "view_component/test_helpers"

module Primer
  module YARD
    class RegistryEntry
      include DocsHelper

      attr_reader :component, :docs

      delegate_missing_to :docs

      def initialize(component, docs)
        @component = component
        @docs = docs
      end

      def metadata
        @metadata ||= begin
          status_module, short_name, class_name = status_module_and_short_name(component)
          status = component.status.to_s
          a11y_reviewed = component.audited_at.nil? ? "false" : "true"

          {
            title: class_name,
            component_id: short_name.underscore,
            status: status.capitalize,
            status_module: status_module,
            short_name: short_name,
            a11y_reviewed: a11y_reviewed
          }
        end
      end

      def constructor
        docs.meths.find(&:constructor?)
      end

      def params
        constructor.tags(:param)
      end

      def slot_methods
        public_methods.select { |mtd| slot_method?(mtd) }
      end

      def non_slot_methods
        public_methods.reject { |mtd| slot_method?(mtd) }
      end

      def slot_method?(mtd)
        mtd[:renders_one] || mtd[:renders_many]
      end

      def public_methods
        # Returns: only public methods that belong to this class (i.e. no inherited methods)
        # excluding the constructor
        @public_methods ||= docs.meths
          .reject { |mtd| mtd.tag(:private) || mtd.name == :initialize }
      end

      def title
        metadata[:title]
      end

      def component_id
        metadata[:component_id]
      end

      def status
        metadata[:status]
      end

      def status_module
        metadata[:status_module]
      end

      def short_name
        metadata[:short_name]
      end

      def a11y_reviewed?
        metadata[:a11y_reviewed]
      end

      def requires_js?
        manifest.components_requiring_js.include?(component)
      end

      def includes_examples?
        manifest.components_with_examples.include?(component)
      end

      private

      def manifest
        Primer::YARD::ComponentManifest
      end
    end


    class Registry
      class << self
        include ViewComponent::TestHelpers
        include Primer::ViewHelper
        include Primer::YARD::DocsHelper

        def make
          registry = ::YARD::RegistryStore.new
          registry.load!(".yardoc")

          new(registry)
        end
      end

      attr_reader :yard_registry

      def initialize(yard_registry)
        @yard_registry = yard_registry
      end

      def find(component)
        return entries[component] if entries.include?(component)

        if (docs = yard_registry.get(component.name))
          entries[component] = RegistryEntry.new(component, docs)
        end
      end

      private

      def entries
        @entries ||= {}
      end
    end
  end
end
