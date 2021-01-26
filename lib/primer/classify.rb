# frozen_string_literal: true

module Primer
  class Classify
    MARGIN_DIRECTION_KEYS = [:mt, :ml, :mb, :mr]
    SPACING_KEYS = ([:m, :my, :mx, :p, :py, :px, :pt, :pl, :pb, :pr] + MARGIN_DIRECTION_KEYS).freeze
    DIRECTION_KEY = :direction
    JUSTIFY_CONTENT_KEY = :justify_content
    ALIGN_ITEMS_KEY = :align_items
    DISPLAY_KEY = :display
    RESPONSIVE_KEYS = ([DISPLAY_KEY, DIRECTION_KEY, JUSTIFY_CONTENT_KEY, ALIGN_ITEMS_KEY, :col, :float] + SPACING_KEYS).freeze
    BREAKPOINTS = ["", "-sm", "-md", "-lg", "-xl"]

    # Keys where we can simply translate { key: value } into ".key-value"
    CONCAT_KEYS = SPACING_KEYS + [:hide, :position, :v, :float, :col, :text, :box_shadow].freeze

    INVALID_CLASS_NAME_PREFIXES =
      (["bg-", "color-", "text-", "d-", "v-align-", "wb-", "text-", "box-shadow-"] + CONCAT_KEYS.map { |k| "#{k}-" }).freeze

    COLOR_KEY = :color
    BG_KEY = :bg
    VERTICAL_ALIGN_KEY = :vertical_align
    WORD_BREAK_KEY = :word_break
    TEXT_KEYS = [:text_align, :font_weight]
    FLEX_KEY = :flex
    FLEX_GROW_KEY = :flex_grow
    FLEX_SHRINK_KEY = :flex_shrink
    ALIGN_SELF_KEY = :align_self
    WIDTH_KEY = :width
    HEIGHT_KEY = :height
    BOX_SHADOW_KEY = :box_shadow
    VISIBILITY_KEY = :visibility

    BOOLEAN_MAPPINGS = {
      underline: {
        mappings: [
          {
            value: true,
            css_class: "text-underline",
          },
          {
            value: false,
            css_class: "no-underline",
          },
        ],
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
    BORDER_KEYS = [:border, :border_color].freeze
    BORDER_MARGIN_KEYS = [:border_top, :border_bottom, :border_left, :border_right].freeze
    BORDER_RADIUS_KEY = :border_radius
    TYPOGRAPHY_KEYS = [:font_size].freeze
    VALID_KEYS = (
      CONCAT_KEYS +
      BOOLEAN_MAPPINGS.keys +
      BORDER_KEYS +
      BORDER_MARGIN_KEYS +
      TYPOGRAPHY_KEYS +
      TEXT_KEYS +
      [
        BORDER_RADIUS_KEY,
        COLOR_KEY,
        BG_KEY,
        DISPLAY_KEY,
        VERTICAL_ALIGN_KEY,
        WORD_BREAK_KEY,
        DIRECTION_KEY,
        JUSTIFY_CONTENT_KEY,
        ALIGN_ITEMS_KEY,
        FLEX_KEY,
        FLEX_GROW_KEY,
        FLEX_SHRINK_KEY,
        ALIGN_SELF_KEY,
        WIDTH_KEY,
        HEIGHT_KEY,
        BOX_SHADOW_KEY,
        VISIBILITY_KEY
      ]
    ).freeze

    class << self
      def call(classes: "", style: nil, **args)
        extracted_results = extract_hash(args)

        extracted_results[:class] = [validated_class_names(classes), extracted_results[:classes]].compact.join(" ").presence
        extracted_results[:style] = [extracted_results[:styles], style].compact.join("").presence
        extracted_results.delete(:classes)
        extracted_results.delete(:styles)

        extracted_results
      end

      private

      def validated_class_names(classes)
        return unless classes.present?

        if ENV["RAILS_ENV"] == "development"
          invalid_class_names =
            classes.split(" ").each_with_object([]) do |class_name, memo|
              if INVALID_CLASS_NAME_PREFIXES.any? { |prefix| class_name.start_with?(prefix) }
                memo << class_name
              end
            end

          if invalid_class_names.any?
            raise ArgumentError.new(
              "Use System Arguments (https://primer.style/view-components/system-arguments) instead of Primer CSS class #{'name'.pluralize(invalid_class_names.length)} #{invalid_class_names.to_sentence}. This warning will not be raised in production.",
            )
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
      # Returns a string of Primer CSS class names to be added to an HTML class attribute
      #
      # Example usage:
      # extract_hash({ mt: 4, py: 2 }) => "mt-4 py-2"
      def extract_hash(styles_hash)
        memo = { classes: [], styles: String.new }
        styles_hash.each do |key, value|
          next unless VALID_KEYS.include?(key)

          if value.is_a?(Array) && !RESPONSIVE_KEYS.include?(key)
            raise ArgumentError, "#{key} does not support responsive values"
          end

          if value.is_a?(Array)
            value.each_with_index do |val, index|
              extract_value(memo, key, val, BREAKPOINTS[index])
            end
          else
            extract_value(memo, key, value, BREAKPOINTS[0])
          end
        end

        memo[:classes] = memo[:classes].join(" ") # 1 allocation

        memo
      end

      def extract_value(memo, key, val, breakpoint)
        return if val.nil?
        if SPACING_KEYS.include?(key)
          if MARGIN_DIRECTION_KEYS.include?(key)
            raise ArgumentError, "value of #{key} must be between -6 and 6" if (val < -6 || val > 6)
          elsif !((key == :mx || key == :my) && val == :auto)
            raise ArgumentError, "value of #{key} must be between 0 and 6" if (val < 0 || val > 6)
          end
        end

        if BOOLEAN_MAPPINGS.has_key?(key)
          BOOLEAN_MAPPINGS[key][:mappings].map { |m| m[:css_class] if m[:value] == val }.compact.each do |css_class|
            memo[:classes] << css_class
          end
        elsif key == BG_KEY
          if val.to_s.starts_with?("#")
            memo[:styles] << "background-color: #{val};"
          else
            memo[:classes] << "bg-#{val.to_s.dasherize}"
          end
        elsif key == COLOR_KEY
          if val[-1] !~ /\D/
            memo[:classes] << "color-#{val.to_s.dasherize}"
          else
            memo[:classes] << "text-#{val.to_s.dasherize}" # 2 allocations
          end
        elsif key == DISPLAY_KEY
          memo[:classes] << "d#{breakpoint}-#{val.to_s.dasherize}"
        elsif key == VERTICAL_ALIGN_KEY
          memo[:classes] << "v-align-#{val.to_s.dasherize}"
        elsif key == WORD_BREAK_KEY
          puts "here"
          memo[:classes] << "wb-#{val.to_s.dasherize}"
        elsif BORDER_KEYS.include?(key)
          memo[:classes] << "border-#{val.to_s.dasherize}" # 2 allocations
        elsif BORDER_MARGIN_KEYS.include?(key)
          memo[:classes] << "#{BORDER_MARGIN_KEY_VALUES[key]}-#{val}"
        elsif key == BORDER_RADIUS_KEY
          memo[:classes] << "rounded-#{val}"
        elsif key == DIRECTION_KEY
          memo[:classes] << "flex#{breakpoint}-#{val.to_s.dasherize}"
        elsif key == JUSTIFY_CONTENT_KEY
          formatted_value = val.to_s.gsub(/(flex\_|space\_)/, "")
          memo[:classes] << "flex#{breakpoint}-justify-#{formatted_value}"
        elsif key == ALIGN_ITEMS_KEY
          memo[:classes] << "flex#{breakpoint}-items-#{val.to_s.gsub("flex_", "")}"
        elsif key == FLEX_KEY
          memo[:classes] << "flex-#{val}"
        elsif key == FLEX_GROW_KEY
          memo[:classes] << "flex-grow-#{val}"
        elsif key == FLEX_SHRINK_KEY
          memo[:classes] << "flex-shrink-#{val}"
        elsif key == ALIGN_SELF_KEY
          memo[:classes] << "flex-self-#{val}" # 2 allocations
        elsif key == WIDTH_KEY || key == HEIGHT_KEY
          if val == :fit || val == :fill
            memo[:classes] << "#{key}-#{val}" # 3 allocations
          else
            memo[key] = val
          end
        elsif TEXT_KEYS.include?(key)
          memo[:classes] << "text-#{val.to_s.dasherize}"
        elsif TYPOGRAPHY_KEYS.include?(key)
          memo[:classes] << "f#{val.to_s.dasherize}"
        elsif MARGIN_DIRECTION_KEYS.include?(key) && val < 0
          memo[:classes] << "#{MARGIN_DIRECTION_KEY_VALUES[key]}#{breakpoint}-n#{val.abs}"
        elsif key == BOX_SHADOW_KEY
          if val == true
            memo[:classes] << "box-shadow"
          else
            memo[:classes] << "box-shadow-#{val.to_s.dasherize}"
          end
        elsif key == VISIBILITY_KEY
          memo[:classes] << "v-#{val.to_s.dasherize}" # 2 allocations
        else
          memo[:classes] << "#{key.to_s.dasherize}#{breakpoint}-#{val.to_s.dasherize}" # 4 allocations
        end
      end
    end
  end
end
