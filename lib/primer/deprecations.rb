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

      def replacement?(component_name)
        !replacement(component_name).nil?
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

      def guide?(component_name)
        !guide(component_name).nil?
      end

      def guide(component_name)
        dep = registered_deprecations[component_name]
        return nil if dep.nil?

        dep[:guide]
      end

      def deprecation_message(component_name)
        return nil unless deprecated?(component_name)

        msg = ["'#{component_name}' has been deprecated."]

        # this nested structure is complex, because it has to
        # match all of the valid scenarios for a component being
        # replaceable, auto-correctable, and having a guide. for
        # more information on what is and is not valid, see the
        # documentation here: docs/contributors/deprecations.md

        if replacement?(component_name) # has replacement
          msg << "Please update your code to use '#{replacement(component_name)}'."
          if correctable?(component_name) # is autocorrectable
            msg << "Use Rubocop's auto-correct, or replace it yourself."
          end
          msg << "See #{guide(component_name)} for more information." if guide?(component_name) # has a guide
        elsif !correctable?(component_name) # no replacement
          if guide?(component_name) # has a guide
            msg << "Unfortunately, there is no direct replacement."
            msg << "See #{guide(component_name)} for more information and available options."
            end
        end

        msg.join(" ")
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
