# frozen_string_literal: true

require "yaml"

module Primer
  # :nodoc:
  class Deprecations
    class << self
      def register(file_path)
        data = YAML.load_file(file_path)
        data["deprecations"].each do |dep|
          register_deprecation(dep["component"], {
            autocorrect: dep["autocorrect"],
            guide: dep["guide"],
            replacement: dep["replacement"]
          })
        end
      end

      def register_deprecation(component, options)
        registered_deprecations[component] = {
          autocorrect: options[:autocorrect],
          guide: options[:guide],
          replacement: options[:replacement]
        }
      end

      def deprecated_components
        registered_deprecations.keys.sort
      end

      def deprecated?(component_name)
        # if the component is registered, it is deprecated
        registered_deprecations.key?(component_name)
      end

      def replacement(component_name)
        dep = registered_deprecations[component_name]
        return nil if dep.nil?

        dep[:replacement]
      end

      def correctable?(component_name)
        dep = registered_deprecations[component_name]
        return false if dep.nil?

        dep[:autocorrect]
      end

      def guide(component_name)
        dep = registered_deprecations[component_name]
        return nil if dep.nil?

        dep[:guide]
      end

      private

      def registered_deprecations
        @registered_deprecations ||= {}
      end
    end

    # auto-load PVC's deprecations
    register(File.expand_path("deprecations.yml", __dir__))
  end
end
