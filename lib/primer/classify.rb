# frozen_string_literal: true

require_relative "classify/utilities"
require_relative "classify/validation"

module Primer
  # :nodoc:
  class Classify
    FLEX_VALUES = [1, :auto].freeze

    FLEX_WRAP_MAPPINGS = {
      wrap: "flex-wrap",
      nowrap: "flex-nowrap",
      reverse: "flex-wrap-reverse"
    }.freeze

    FLEX_ALIGN_SELF_VALUES = [:auto, :start, :end, :center, :baseline, :stretch].freeze

    FLEX_DIRECTION_VALUES = [:column, :column_reverse, :row, :row_reverse].freeze

    FLEX_JUSTIFY_CONTENT_VALUES = [:flex_start, :flex_end, :center, :space_between, :space_around].freeze

    FLEX_ALIGN_ITEMS_VALUES = [:flex_start, :flex_end, :center, :baseline, :stretch].freeze

    LOOKUP = Primer::Classify::Utilities::UTILITIES

    class << self
      # Utility for mapping component configuration into Primer CSS class names.
      #
      # **args can contain utility keys that mimic the interface used by
      # https://github.com/primer/components, as well as the special entries :classes
      # and :style.
      #
      # Returns a hash containing two entries. The :classes entry is a string of
      # Primer CSS class names, including any classes given in the :classes entry
      # in **args. The :style entry is the value of the given :style entry given in
      # **args.
      #
      #
      # Example usage:
      # extract_css_attrs({ mt: 4, py: 2 }) => { classes: "mt-4 py-2", style: nil }
      # extract_css_attrs(classes: "d-flex", mt: 4, py: 2) => { classes: "d-flex mt-4 py-2", style: nil }
      # extract_css_attrs(classes: "d-flex", style: "float: left", mt: 4, py: 2) => { classes: "d-flex mt-4 py-2", style: "float: left" }
      #
      def call(args = {})
        style = nil
        classes = [].tap do |result|
          args.each do |key, val|
            case key
            when :classes
              # insert :classes first to avoid huge doc diffs
              if (class_names = validated_class_names(val))
                result.unshift(class_names)
              end
              next
            when :style
              style = val
              next
            end

            next unless LOOKUP[key]

            if val.is_a?(Array)
              # A while loop is ~3.5x faster than Array#each.
              brk = 0
              while brk < val.size
                item = val[brk]

                if item.nil?
                  brk += 1
                  next
                end

                # Believe it or not, three calls to Hash#[] and an inline rescue
                # are about 30% faster than Hash#dig. It also ensures validate is
                # only called when necessary, i.e. when the class can't be found
                # in the lookup table.
                found = (LOOKUP[key][item][brk] rescue nil) || validate(key, item, brk)
                # rubocop:enable Style/RescueModifier
                result << found if found
                brk += 1
              end
            else
              next if val.nil?

              # rubocop:disable Style/RescueModifier
              found = (LOOKUP[key][val][0] rescue nil) || validate(key, val, 0)
              # rubocop:enable Style/RescueModifier
              result << found if found
            end
          end
        end.join(" ")

        # This is much faster than Rails' presence method.
        {
          class: !classes || classes.empty? ? nil : classes,
          style: !style || style.empty? ? nil : style
        }
        # rubocop:enable Rails/Blank
      end

      private

      def validate(key, val, brk)
        brk_str = Primer::Classify::Utilities::BREAKPOINTS[brk]
        Primer::Classify::Utilities.validate(key, val, brk_str)
      end

      def validated_class_names(classes)
        return if classes.blank?

        if raise_on_invalid_options? && !ENV["PRIMER_WARNINGS_DISABLED"]
          invalid_class_names =
            classes.split.each_with_object([]) do |class_name, memo|
              memo << class_name if Primer::Classify::Validation.invalid?(class_name)
            end

          if invalid_class_names.any?
            raise ArgumentError, "Use System Arguments (https://primer.style/view-components/system-arguments) "\
              "instead of Primer CSS class #{'name'.pluralize(invalid_class_names.length)} #{invalid_class_names.to_sentence}. "\
              "This warning will not be raised in production. Set PRIMER_WARNINGS_DISABLED=1 to disable this warning."
          end
        end

        classes
      end

      def raise_on_invalid_options?
        Rails.application.config.primer_view_components.raise_on_invalid_options
      end
    end
  end
end
