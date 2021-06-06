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
            get_selector(key, val, breakpoint)
          end
        end

        # Does the Utilitiy class support the given key
        #
        # returns Boolean
        def supported_key?(key)
          Primer::Classify::UTILITIES[key].present?
        end

        # Does the Utilitiy class support the given key and value
        #
        # returns Boolean
        def supported_value?(key, val)
          supported_key?(key) && Primer::Classify::UTILITIES[key][val].present?
        end

        # Is the key and value responsive
        #
        # returns Boolean
        def responsive?(key, val)
          supported_value?(key, val) && Primer::Classify::UTILITIES[key][val].count > 1
        end

        # Get the options for the given key
        #
        # returns Array or nil if key not supported
        def mappings(key)
          return unless supported_key?(key)

          Primer::Classify::UTILITIES[key].keys
        end

        # Extract hash from classes ie. "mr-1 mb-2 foo" => { mr: 1, mb: 2, classes: "foo" }
        def classes_to_hash(classes)
          obj = {}
          classes = classes.split(" ")
          classes.reject! do |c|
            key, value, index = find_selector(c)
            next false if key.nil?

            # Create array if nil
            obj[key] = Array.new(5, nil) if obj[key].nil?
            obj[key][index] = value
            next true
          end

          # Transform responsive arrays into arrays without trailing nil
          obj.transform_values! do |v|
            v = v.reverse.drop_while(&:nil?).reverse
            if v.count == 1
              v.first
            else
              v
            end
          end

          obj[:classes] = classes.join(" ") if classes.any?
          obj
        end

        private

        def find_selector(selector)
          Primer::Classify::UTILITIES.each do |k, v|
            v.each do |vk, vv|
              next unless vv.include?(selector)

              return [k, vk, vv.index(selector)]
            end
          end

          nil
        end

        def get_selector(key, val, breakpoint)
          Primer::Classify::UTILITIES[key][val][Primer::Classify::BREAKPOINTS.index(breakpoint)]
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
