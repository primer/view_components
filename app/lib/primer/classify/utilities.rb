# frozen_string_literal: true

# :nodoc:
module Primer
  class Classify
    # Handler for PrimerCSS utility classes loaded from utilities.rake
    class Utilities
      class << self
        def classname(key, val, breakpoint = "")
          if (valid = validate(key, val, breakpoint))
            valid
          else
            # Get selector
            Primer::Classify::UTILITIES[:mappings][key][val][Primer::Classify::BREAKPOINTS.index(breakpoint)]
          end
        end

        # Does the Utilitiy class support the given key
        #
        # returns Boolean
        def supported_key?(key)
          Primer::Classify::UTILITIES[:mappings][key].present?
        end

        # Does the Utilitiy class support the given key and value
        #
        # returns Boolean
        def supported_value?(key, val)
          supported_key?(key) && Primer::Classify::UTILITIES[:mappings][key][val].present?
        end

        # Does the given selector exist in the utilities file
        #
        # returns Boolean
        def supported_selector?(selector)
          Primer::Classify::UTILITIES[:selectors][selector].present?
        end

        # Is the key and value responsive
        #
        # returns Boolean
        def responsive?(key, val)
          supported_value?(key, val) && Primer::Classify::UTILITIES[:mappings][key][val].count > 1
        end

        # Get the options for the given key
        #
        # returns Array or nil if key not supported
        def mappings(key)
          return unless supported_key?(key)

          Primer::Classify::UTILITIES[:mappings][key].keys
        end

        # Extract hash from classes ie. "mr-1 mb-2 foo" => { mr: 1, mb: 2, classes: "foo" }
        def classes_to_hash(classes)
          # This method is too slow to run in production
          return { classes: classes } if Rails.env.production?

          obj = {}
          classes = classes.split(" ")
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

        private

        def find_selector(selector)
          # Search each key/value_hash pair, eg. key `:mr` and value_hash `{ 0 => [ "mr-0", "mr-sm-0", "mr-md-0", "mr-lg-0", "mr-xl-0" ] }`
          Primer::Classify::UTILITIES[:mappings].each do |key, value_hash|
            # Each value hash will also contain an array of classnames for breakpoints
            # Key argument `0`, classes `[ "mr-0", "mr-sm-0", "mr-md-0", "mr-lg-0", "mr-xl-0" ]`
            value_hash.each do |key_argument, classnames|
              # Skip each value hash until we get one with the selector
              next unless classnames.include?(selector)

              # Return [:mr, 0, 1]
              # has index of classname, so we can match it up with responsvie array `mr: [nil, 0]`
              return [key, key_argument, classnames.index(selector)]
            end
          end

          nil
        end

        def validate(key, val, breakpoint)
          unless supported_key?(key)
            raise ArgumentError, "#{key} is not a valid Primer utility key" unless Rails.env.production?

            return ""
          end

          unless breakpoint.empty? || responsive?(key, val)
            raise ArgumentError, "#{key} does not support responsive values" unless Rails.env.production?

            return ""
          end

          unless supported_value?(key, val)
            raise ArgumentError, "#{val} is not a valid value for :#{key}. Use one of #{mappings(key)}" unless Rails.env.production?

            return ""
          end

          nil
        end
      end
    end
  end
end
