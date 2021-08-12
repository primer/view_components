# frozen_string_literal: true

require "yaml"

# :nodoc:
module Primer
  class Classify
    # Handler for PrimerCSS utility classes loaded from utilities.rake
    class Utilities
      # Load the utilities.yml file.
      # Disabling because we want to load symbols, strings, and integers from the .yml file
      # rubocop:disable Security/YAMLLoad
      UTILITIES = YAML.load(
        File.read(
          File.join(File.dirname(__FILE__), "./utilities.yml")
        )
      ).freeze
      # rubocop:enable Security/YAMLLoad
      BREAKPOINTS = ["", "-sm", "-md", "-lg", "-xl"].freeze

      # Replacements for some classnames that end up being a different argument key
      REPLACEMENT_KEYS = {
        "^anim" => "animation",
        "^v-align" => "vertical_align",
        "^d" => "display",
        "^wb" => "word_break",
        "^v" => "visibility",
        "^width" => "w",
        "^height" => "h"
      }.freeze

      class << self
        def classname(key, val, breakpoint = "")
          if (valid = validate(key, val, breakpoint))
            valid
          else
            # Get selector
            UTILITIES[key][val][BREAKPOINTS.index(breakpoint)]
          end
        end

        # Does the Utilitiy class support the given key
        #
        # returns Boolean
        def supported_key?(key)
          UTILITIES[key].present?
        end

        # Does the Utilitiy class support the given key and value
        #
        # returns Boolean
        def supported_value?(key, val)
          supported_key?(key) && UTILITIES[key][val].present?
        end

        # Does the given selector exist in the utilities file
        #
        # returns Boolean
        def supported_selector?(selector)
          # This method is too slow to run in production
          return false if ENV["RAILS_ENV"] == "production"

          find_selector(selector).present?
        end

        # Is the key and value responsive
        #
        # returns Boolean
        def responsive?(key, val)
          supported_value?(key, val) && UTILITIES[key][val].count > 1
        end

        # Get the options for the given key
        #
        # returns Array or nil if key not supported
        def mappings(key)
          return unless supported_key?(key)

          UTILITIES[key].keys
        end

        # Extract hash from classes ie. "mr-1 mb-2 foo" => { mr: 1, mb: 2, classes: "foo" }
        def classes_to_hash(classes)
          # This method is too slow to run in production
          return { classes: classes } if ENV["RAILS_ENV"] == "production"

          obj = {}
          classes = classes.split
          # Loop through all classes supplied and reject ones we find a match for
          # So when we're at the end of the loop we have classes left with any non-system classes.
          classes.reject! do |classname|
            key, value, index = find_selector(classname)
            next false if key.nil?

            # Create array if nil
            obj[key] = Array.new(5, nil) if obj[key].nil?
            # Place the arguments in the responsive array based on index mr: [nil, 2]
            obj[key][index] = value
            next true
          end

          # Transform responsive arrays into arrays without trailing nil, so `mr: [1, nil, nil, nil, nil]` becomes `mr: 1`
          obj.transform_values! do |value|
            value = value.reverse.drop_while(&:nil?).reverse
            if value.count == 1
              value.first
            else
              value
            end
          end

          # Add back the non-system classes
          obj[:classes] = classes.join(" ") if classes.any?
          obj
        end

        def classes_to_args(classes)
          classes_to_hash(classes).map do |key, value|
            val = case value
                  when Symbol
                    ":#{value}"
                  when String
                    value.to_json
                  else
                    value
                  end

            "#{key}: #{val}"
          end.join(", ")
        end

        private

        def find_selector(selector)
          key = infer_selector_key(selector)
          value_hash = UTILITIES[key]

          return nil if value_hash.blank?

          # Each value hash will also contain an array of classnames for breakpoints
          # Key argument `0`, classes `[ "mr-0", "mr-sm-0", "mr-md-0", "mr-lg-0", "mr-xl-0" ]`
          value_hash.each do |key_argument, classnames|
            # Skip each value hash until we get one with the selector
            next unless classnames.include?(selector)

            # Return [:mr, 0, 1]
            # has index of classname, so we can match it up with responsvie array `mr: [nil, 0]`
            return [key, key_argument, classnames.index(selector)]
          end

          nil
        end

        def infer_selector_key(selector)
          REPLACEMENT_KEYS.each do |k, v|
            return v.to_sym if selector.match?(Regexp.new(k))
          end

          selector.split("-").first.to_sym
        end

        def validate(key, val, breakpoint)
          unless supported_key?(key)
            raise ArgumentError, "#{key} is not a valid Primer utility key" unless ENV["RAILS_ENV"] == "production"

            return ""
          end

          unless breakpoint.empty? || responsive?(key, val)
            raise ArgumentError, "#{key} does not support responsive values" unless ENV["RAILS_ENV"] == "production"

            return ""
          end

          unless supported_value?(key, val)
            raise ArgumentError, "#{val} is not a valid value for :#{key}. Use one of #{mappings(key)}" unless ENV["RAILS_ENV"] == "production"

            return ""
          end

          nil
        end
      end
    end
  end
end
