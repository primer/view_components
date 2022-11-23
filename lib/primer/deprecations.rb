# frozen_string_literal: true

require 'yaml'

module Primer
  # :nodoc:
  class Deprecations
    class << self
      def register(file_path)
        data = YAML.load_file(file_path)
        data["deprecations"].each do |dep|
          component = dep["component"]
          deprecations[component] = {
            autocorrect: dep["autocorrect"],
            guide: dep["guide"],
            replacement: dep["replacement"]
          }
        end
      end

      def deprecated?(component_name)
        # if the component is registered, it is deprecated
        deprecations.key?(component_name)
      end

      def replacement(component_name)
        dep = deprecations[component_name]
        return nil if dep.nil?

        dep[:replacement]
      end

      def correctable?(component_name)
        dep = deprecations[component_name]
        return false if dep.nil?

        dep[:autocorrect]
      end

      def guide(component_name)
        dep = deprecations[component_name]
        return nil if dep.nil?

        dep[:guide]
      end

      private

      def deprecations
        @deprecations ||= {}
      end
    end

    # auto-load PVC's deprecations
    begin
      config_path = File.expand_path("deprecations.yml", __dir__)
      self.register(config_path)
    end
  end
end
