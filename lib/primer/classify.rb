# frozen_string_literal: true

require_relative "classify/cache"
require_relative "classify/flex"
require_relative "classify/utilities"
require_relative "classify/validation"

module Primer
  # :nodoc:
  class Classify
    # Keys where we can simply translate { key: value } into ".key-value"
    CONCAT_KEYS = %i[text box_shadow].freeze

    TEXT_KEYS = %i[font_family font_style font_weight text_align text_transform].freeze
    BOX_SHADOW_KEY = :box_shadow

    BREAKPOINTS = ["", "-sm", "-md", "-lg", "-xl"].freeze

    BOOLEAN_MAPPINGS = {
      underline: {
        mappings: [
          {
            value: true,
            css_class: "text-underline"
          },
          {
            value: false,
            css_class: "no-underline"
          }
        ]
      },
      top: {
        mappings: [
          {
            value: false,
            css_class: "top-0"
          }
        ]
      },
      bottom: {
        mappings: [
          {
            value: false,
            css_class: "bottom-0"
          }
        ]
      },
      left: {
        mappings: [
          {
            value: false,
            css_class: "left-0"
          }
        ]
      },
      right: {
        mappings: [
          {
            value: false,
            css_class: "right-0"
          }
        ]
      }
    }.freeze
    BORDER_KEY = :border
    BORDER_MARGIN_KEYS = %i[border_top border_bottom border_left border_right].freeze
    BORDER_RADIUS_KEY = :border_radius
    TYPOGRAPHY_KEYS = [:font_size].freeze
    VALID_KEYS = (
      Primer::Classify::Utilities::UTILITIES.keys +
      CONCAT_KEYS +
      BOOLEAN_MAPPINGS.keys +
      BORDER_MARGIN_KEYS +
      TYPOGRAPHY_KEYS +
      TEXT_KEYS +
      Primer::Classify::Flex::KEYS +
      [
        BORDER_KEY,
        BORDER_RADIUS_KEY,
        BOX_SHADOW_KEY
      ]
    ).freeze

    class << self
      def call(classes: "", style: nil, **args)
        extracted_classes = extract_css_attrs(args)

        classes = +"#{validated_class_names(classes)} #{extracted_classes}"
        classes.strip!

        {
          class: presence(classes),
          style: presence(style)
        }
      end

      private

      # do this instead of using Rails' presence/blank?, which are a lot slower
      def presence(obj)
        # rubocop:disable Rails/Blank
        !obj || obj.empty? ? nil : obj
        # rubocop:enable Rails/Blank
      end

      def validated_class_names(classes)
        return if classes.blank?

        if force_system_arguments? && !ENV["PRIMER_WARNINGS_DISABLED"]
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

      # NOTE: This is a fairly naive implementation that we're building as we go.
      # Feel free to refactor as this is thoroughly tested.
      #
      # Utility for mapping component configuration into Primer CSS class names
      #
      # styles_hash - A hash with utility keys that mimic the interface used by https://github.com/primer/components
      #
      # Returns a string of Primer CSS class names and style attributes to be added to an HTML tag.
      #
      # Example usage:
      # extract_css_attrs({ mt: 4, py: 2 }) => "mt-4 py-2"
      def extract_css_attrs(styles_hash)
        classes = []

        styles_hash.each do |key, value|
          if value.is_a?(Array)
            raise ArgumentError, "#{key} does not support responsive values" unless Primer::Classify::Flex::RESPONSIVE_KEYS.include?(key) || Primer::Classify::Utilities.supported_key?(key)

            value.each_with_index do |val, index|
              extract_one_css_attr(classes, key, val, BREAKPOINTS[index])
            end
          else
            extract_one_css_attr(classes, key, value, BREAKPOINTS[0])
          end
        end

        classes.join(" ")
      end

      def extract_one_css_attr(classes, key, val, breakpoint)
        found_classes = Primer::Classify::Cache.instance.fetch(breakpoint, key, val) do
          classes_from(key, val, breakpoint)
        end

        classes << found_classes if found_classes
      end

      def classes_from(key, val, breakpoint)
        return if val.nil? || val == ""

        if Primer::Classify::Utilities.supported_key?(key)
          Primer::Classify::Utilities.classname(key, val, breakpoint)
        elsif BOOLEAN_MAPPINGS.key?(key)
          bools = BOOLEAN_MAPPINGS[key][:mappings].each_with_object([]) do |m, memo|
            memo << m[:css_class] if m[:value] == val && m[:css_class].present?
          end
          bools.empty? ? nil : bools.join(" ")
        elsif key == BORDER_KEY
          if val == true
            "border"
          else
            "border-#{val.to_s.dasherize}"
          end
        elsif BORDER_MARGIN_KEYS.include?(key)
          "#{key.to_s.dasherize}-#{val}"
        elsif key == BORDER_RADIUS_KEY
          "rounded-#{val}"
        elsif Primer::Classify::Flex::KEYS.include?(key)
          Primer::Classify::Flex.classes(key, val, breakpoint)
        elsif TEXT_KEYS.include?(key)
          "text-#{val.to_s.dasherize}"
        elsif TYPOGRAPHY_KEYS.include?(key)
          if val == :small || val == :normal
            "text-#{val.to_s.dasherize}"
          else
            "f#{val.to_s.dasherize}"
          end
        elsif key == BOX_SHADOW_KEY
          if val == true
            "color-shadow-small"
          elsif val == :none || val.blank?
            "box-shadow-none"
          else
            "color-shadow-#{val.to_s.dasherize}"
          end
        end
      end

      def force_system_arguments?
        Rails.application.config.primer_view_components.force_system_arguments
      end
    end

    Cache.instance.preload!
  end
end
