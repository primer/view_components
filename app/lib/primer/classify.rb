# frozen_string_literal: true

module Primer
  # :nodoc:
  class Classify
    DISPLAY_KEY = :display
    SPACING_KEYS = Primer::Classify::Spacing::KEYS

    # Keys where we can simply translate { key: value } into ".key-value"
    CONCAT_KEYS = SPACING_KEYS + %i[hide position v float col text box_shadow].freeze

    INVALID_CLASS_NAME_PREFIXES =
      (["bg-", "color-", "text-", "d-", "v-align-", "wb-", "box-shadow-"] + CONCAT_KEYS.map { |k| "#{k}-" }).freeze

    COLOR_KEY = :color
    BG_KEY = :bg
    VERTICAL_ALIGN_KEY = :vertical_align
    WORD_BREAK_KEY = :word_break
    TEXT_KEYS = %i[font_family font_style font_weight text_align text_transform].freeze
    WIDTH_KEY = :width
    HEIGHT_KEY = :height
    BOX_SHADOW_KEY = :box_shadow
    VISIBILITY_KEY = :visibility
    ANIMATION_KEY = :animation
    CONTAINER_KEY = :container

    BREAKPOINTS = ["", "-sm", "-md", "-lg", "-xl"].freeze
    RESPONSIVE_KEYS = ([DISPLAY_KEY, :col, :float] + SPACING_KEYS + Primer::Classify::Flex::RESPONSIVE_KEYS).freeze

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
      CONCAT_KEYS +
      BOOLEAN_MAPPINGS.keys +
      BORDER_MARGIN_KEYS +
      TYPOGRAPHY_KEYS +
      TEXT_KEYS +
      Primer::Classify::Flex::KEYS +
      [
        BORDER_KEY,
        BORDER_COLOR_KEY,
        BORDER_RADIUS_KEY,
        COLOR_KEY,
        BG_KEY,
        DISPLAY_KEY,
        VERTICAL_ALIGN_KEY,
        WORD_BREAK_KEY,
        WIDTH_KEY,
        HEIGHT_KEY,
        BOX_SHADOW_KEY,
        VISIBILITY_KEY,
        ANIMATION_KEY,
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
              memo << class_name if INVALID_CLASS_NAME_PREFIXES.any? { |prefix| class_name.start_with?(prefix) }
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
            raise ArgumentError, "#{key} does not support responsive values" unless RESPONSIVE_KEYS.include?(key)

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

        if SPACING_KEYS.include?(key)
          memo[:classes] << Primer::Classify::Spacing.spacing(key, val, breakpoint)
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
        elsif key == DISPLAY_KEY
          memo[:classes] << "d#{breakpoint}-#{val.to_s.dasherize}"
        elsif key == VERTICAL_ALIGN_KEY
          memo[:classes] << "v-align-#{val.to_s.dasherize}"
        elsif key == WORD_BREAK_KEY
          memo[:classes] << "wb-#{val.to_s.dasherize}"
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
        elsif key == VISIBILITY_KEY
          memo[:classes] << "v-#{val.to_s.dasherize}"
        elsif key == ANIMATION_KEY
          memo[:classes] << if val == :grow
                              "hover-grow"
                            else
                              "anim-#{val.to_s.dasherize}"
                            end
        elsif key == CONTAINER_KEY
          memo[:classes] << "container-#{val.to_s.dasherize}"
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
