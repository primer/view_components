# frozen_string_literal: true

require_relative "classify/cache"
require_relative "classify/flex"
require_relative "classify/functional_background_colors"
require_relative "classify/functional_border_colors"
require_relative "classify/functional_text_colors"
require_relative "classify/grid"
require_relative "classify/utilities"

module Primer
  # :nodoc:
  class Classify
    # Load the utilities.yml file.
    # Disabling because we want to load symbols, strings, and integers from the .yml file
    # rubocop:disable Security/YAMLLoad
    UTILITIES = YAML.load(
      File.read(
        File.join(File.dirname(__FILE__), "./classify/utilities.yml")
      )
    ).freeze
    # rubocop:enable Security/YAMLLoad

    # Keys where we can simply translate { key: value } into ".key-value"
    CONCAT_KEYS = %i[text box_shadow].freeze

    INVALID_CLASS_NAME_PREFIXES =
      (["bg-", "color-", "text-", "box-shadow-"] + CONCAT_KEYS.map { |k| "#{k}-" }).freeze

    COLOR_KEY = :color
    BG_KEY = :bg
    TEXT_KEYS = %i[font_family font_style font_weight text_align text_transform].freeze
    WIDTH_KEY = :width
    HEIGHT_KEY = :height
    BOX_SHADOW_KEY = :box_shadow
    CONTAINER_KEY = :container

    BREAKPOINTS = ["", "-sm", "-md", "-lg", "-xl"].freeze
    RESPONSIVE_KEYS = ([Primer::Classify::Grid::COL_KEY] + Primer::Classify::Flex::RESPONSIVE_KEYS).freeze

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
    BORDER_COLOR_KEY = :border_color
    BORDER_MARGIN_KEYS = %i[border_top border_bottom border_left border_right].freeze
    BORDER_RADIUS_KEY = :border_radius
    TYPOGRAPHY_KEYS = [:font_size].freeze
    VALID_KEYS = (
      UTILITIES.keys +
      CONCAT_KEYS +
      BOOLEAN_MAPPINGS.keys +
      BORDER_MARGIN_KEYS +
      TYPOGRAPHY_KEYS +
      TEXT_KEYS +
      Primer::Classify::Flex::KEYS +
      Primer::Classify::Grid::KEYS +
      [
        BORDER_KEY,
        BORDER_COLOR_KEY,
        BORDER_RADIUS_KEY,
        COLOR_KEY,
        BG_KEY,
        WIDTH_KEY,
        HEIGHT_KEY,
        BOX_SHADOW_KEY,
        CONTAINER_KEY
      ]
    ).freeze

    class << self
      def call(classes: "", style: nil, **args)
        extracted_results = extract_hash(args)

        extracted_results[:class] = [
          validated_class_names(classes),
          extracted_results.delete(:classes)
        ].compact.join(" ").strip.presence

        extracted_results[:style] = [
          extracted_results.delete(:styles),
          style
        ].compact.join("").presence

        extracted_results
      end

      private

      def validated_class_names(classes)
        return if classes.blank?

        if force_system_arguments? && !ENV["PRIMER_WARNINGS_DISABLED"]
          invalid_class_names =
            classes.split(" ").each_with_object([]) do |class_name, memo|
              memo << class_name if INVALID_CLASS_NAME_PREFIXES.any? { |prefix| class_name.start_with?(prefix) } || Primer::Classify::Utilities.supported_selector?(class_name)
            end

          raise ArgumentError, "Use System Arguments (https://primer.style/view-components/system-arguments) instead of Primer CSS class #{'name'.pluralize(invalid_class_names.length)} #{invalid_class_names.to_sentence}. This warning will not be raised in production. Set PRIMER_WARNINGS_DISABLED=1 to disable this warning." if invalid_class_names.any?
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
      # Returns a string of Primer CSS class names to be added to an HTML class attribute
      #
      # Example usage:
      # extract_hash({ mt: 4, py: 2 }) => "mt-4 py-2"
      def extract_hash(styles_hash)
        memo = { classes: [], styles: +"" }
        styles_hash.each do |key, value|
          next unless VALID_KEYS.include?(key)

          if value.is_a?(Array)
            raise ArgumentError, "#{key} does not support responsive values" unless RESPONSIVE_KEYS.include?(key) || Primer::Classify::Utilities.supported_key?(key)

            value.each_with_index do |val, index|
              Primer::Classify::Cache.read(memo, key, val, BREAKPOINTS[index]) || extract_value(memo, key, val, BREAKPOINTS[index])
            end
          else
            Primer::Classify::Cache.read(memo, key, value, BREAKPOINTS[0]) || extract_value(memo, key, value, BREAKPOINTS[0])
          end
        end

        memo[:classes] = memo[:classes].join(" ")

        memo
      end

      def extract_value(memo, key, val, breakpoint)
        return if val.nil? || val == ""

        if Primer::Classify::Utilities.supported_key?(key)
          memo[:classes] << Primer::Classify::Utilities.classname(key, val, breakpoint)
        elsif BOOLEAN_MAPPINGS.key?(key)
          BOOLEAN_MAPPINGS[key][:mappings].each do |m|
            memo[:classes] << m[:css_class] if m[:value] == val && m[:css_class].present?
          end
        elsif key == BG_KEY
          if val.to_s.start_with?("#")
            memo[:styles] << "background-color: #{val};"
          else
            memo[:classes] << Primer::Classify::FunctionalBackgroundColors.color(val)
          end
        elsif key == COLOR_KEY
          memo[:classes] << Primer::Classify::FunctionalTextColors.color(val)
        elsif key == BORDER_KEY
          border_value = if val == true
                           "border"
                         else
                           "border-#{val.to_s.dasherize}"
                         end

          memo[:classes] << border_value
        elsif key == BORDER_COLOR_KEY
          memo[:classes] << Primer::Classify::FunctionalBorderColors.color(val)
        elsif BORDER_MARGIN_KEYS.include?(key)
          memo[:classes] << "#{key.to_s.dasherize}-#{val}"
        elsif key == BORDER_RADIUS_KEY
          memo[:classes] << "rounded-#{val}"
        elsif Primer::Classify::Flex::KEYS.include?(key)
          memo[:classes] << Primer::Classify::Flex.classes(key, val, breakpoint)
        elsif Primer::Classify::Grid::KEYS.include?(key)
          memo[:classes] << Primer::Classify::Grid.classes(key, val, breakpoint)
        elsif key == WIDTH_KEY || key == HEIGHT_KEY
          if val == :fit
            memo[:classes] << "#{key}-#{val}"
          else
            memo[key] = val
          end
        elsif TEXT_KEYS.include?(key)
          memo[:classes] << "text-#{val.to_s.dasherize}"
        elsif TYPOGRAPHY_KEYS.include?(key)
          memo[:classes] << if val == :small || val == :normal
                              "text-#{val.to_s.dasherize}"
                            else
                              "f#{val.to_s.dasherize}"
                            end
        elsif key == BOX_SHADOW_KEY
          memo[:classes] << if val == true
                              "color-shadow-small"
                            elsif val == :none || val.blank?
                              "box-shadow-none"
                            else
                              "color-shadow-#{val.to_s.dasherize}"
                            end
        else
          memo[:classes] << "#{key.to_s.dasherize}#{breakpoint}-#{val.to_s.dasherize}"
        end
      end

      def force_system_arguments?
        Rails.application.config.primer_view_components.force_system_arguments
      end
    end

    Cache.preload!
  end
end
