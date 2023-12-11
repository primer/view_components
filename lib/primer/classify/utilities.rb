# frozen_string_literal: true

require "yaml"

# :nodoc:
module Primer
  class Classify
    # Handler for PrimerCSS utility classes loaded from utilities.rake
    class Utilities
      UTILITIES = YAML.safe_load(
        File.read(
          File.join(File.dirname(__FILE__), "utilities.yml")
        ),
        permitted_classes: [Symbol]
      ).freeze

      BREAKPOINTS = ["", "-sm", "-md", "-lg", "-xl"].freeze

      # Replacements for some classnames that end up being a different argument key
      REPLACEMENT_KEYS = {
        "^anim" => "animation",
        "^v-align" => "vertical_align",
        "^d" => "display",
        "^wb" => "word_break",
        "^v" => "visibility",
        "^width" => "w",
        "^height" => "h",
        "^color-bg" => "bg",
        "^color-border" => "border_color",
        "^color-fg" => "color"
      }.freeze

      SUPPORTED_KEY_CACHE = Hash.new { |h, k| h[k] = !UTILITIES[k].nil? }
      BREAKPOINT_INDEX_CACHE = Hash.new { |h, k| h[k] = BREAKPOINTS.index(k) }

      class << self
        attr_accessor :validate_class_names
        alias validate_class_names? validate_class_names

        def classname(key, val, breakpoint = "")
          # For cases when `argument: false` is passed in, treat like we would nil
          return nil unless val

          if (valid = validate(key, val, breakpoint))
            valid
          else
            # Get selector
            UTILITIES[key][val][BREAKPOINT_INDEX_CACHE[breakpoint]]
          end
        end

        # Does the Utility class support the given key
        #
        # returns Boolean
        def supported_key?(key)
          SUPPORTED_KEY_CACHE[key]
        end

        # Does the Utility class support the given key and value
        #
        # returns Boolean
        def supported_value?(key, val)
          supported_key?(key) && !UTILITIES[key][val].nil?
        end

        # Does the given selector exist in the utilities file
        #
        # returns Boolean
        def supported_selector?(selector)
          # This method is too slow to run in production
          return false unless validate_class_names?

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
        def classes_to_hash(classes, force: true)
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
          hash_to_args(classes_to_hash(classes))
        end

        def hash_to_args(hash)
          hash.map do |key, value|
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

        def validate(key, val, breakpoint)
          unless supported_key?(key)
            raise ArgumentError, "#{key} is not a valid Primer utility key" if validate_class_names?

            return ""
          end

          unless breakpoint.empty? || responsive?(key, val)
            raise ArgumentError, "#{key} does not support responsive values" if validate_class_names?

            return ""
          end

          unless supported_value?(key, val)
            raise ArgumentError, "#{val} is not a valid value for :#{key}. Use one of #{mappings(key)}" if validate_class_names?

            return nil if [true, false].include?(val)

            return "#{key.to_s.dasherize}-#{val.to_s.dasherize}"
          end

          nil
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
            # has index of classname, so we can match it up with responsive array `mr: [nil, 0]`
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
      end
    end
  end
end
