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
    BREAKPOINTS = ["", "-sm", "-md", "-lg"]

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
    BORDER_KEYS = [:border, :border_color, :border_top, :border_bottom, :border_left, :border_right].freeze
    TYPOGRAPHY_KEYS = [:font_size].freeze
    VALID_KEYS = (
      CONCAT_KEYS +
      BOOLEAN_MAPPINGS.keys +
      BORDER_KEYS +
      TYPOGRAPHY_KEYS +
      TEXT_KEYS +
      [
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
        BOX_SHADOW_KEY
      ]
    ).freeze

    class << self
      def call(classes: "", style: nil, **args)
        extracted_results = extract_hash(args)

        {
          class: [validated_class_names(classes), extracted_results[:classes]].compact.join(" ").presence,
          style: [extracted_results[:styles], style].compact.join("").presence,
        }.merge(extracted_results.except(:classes, :styles))
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
              "Primer CSS class #{'name'.pluralize(invalid_class_names.length)} \
              #{invalid_class_names.to_sentence} #{'is'.pluralize(invalid_class_names.length)} \
              not allowed, use style arguments instead (https://github.com/primer/view_components#built-in-styling-arguments). This warning will not be raised in production.",
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
        out = styles_hash.each_with_object({ classes: [], styles: [] }) do |(key, value), memo|
          next unless VALID_KEYS.include?(key)

          if value.is_a?(Array) && !RESPONSIVE_KEYS.include?(key)
            raise ArgumentError, "#{key} does not support responsive values"
          end

          Array(value).each_with_index do |val, index|
            next if val.nil?

            if SPACING_KEYS.include?(key)
              if MARGIN_DIRECTION_KEYS.include?(key)
                raise ArgumentError, "value of #{key} must be between -6 and 6" if (val < -6 || val > 6)
              elsif !((key == :mx || key == :my) && val == :auto)
                raise ArgumentError, "value of #{key} must be between 0 and 6" if (val < 0 || val > 6)
              end
            end

            dasherized_val = val.to_s.dasherize
            dasherized_key = key.to_s.dasherize

            breakpoint = BREAKPOINTS[index]

            if BOOLEAN_MAPPINGS.has_key?(key)
              BOOLEAN_MAPPINGS[key][:mappings].map { |m| m[:css_class] if m[:value] == val }.compact.each do |css_class|
                memo[:classes] << css_class
              end
            elsif key == BG_KEY
              if val.to_s.starts_with?("#")
                memo[:styles] << "background-color: #{val};"
              else
                memo[:classes] << "bg-#{dasherized_val}"
              end
            elsif key == COLOR_KEY
              if val.to_s.chars.last !~ /\D/
                memo[:classes] << "color-#{dasherized_val}"
              else
                memo[:classes] << "text-#{dasherized_val}"
              end
            elsif key == DISPLAY_KEY
              memo[:classes] << "d#{breakpoint}-#{dasherized_val}"
            elsif key == VERTICAL_ALIGN_KEY
              memo[:classes] << "v-align-#{dasherized_val}"
            elsif key == WORD_BREAK_KEY
              memo[:classes] << "wb-#{dasherized_val}"
            elsif BORDER_KEYS.include?(key)
              if (key == :border || key == :border_color)
                memo[:classes] << "border-#{dasherized_val}"
              else
                memo[:classes] << "#{dasherized_key}-#{val}"
              end
            elsif key == DIRECTION_KEY
              memo[:classes] << "flex#{breakpoint}-#{dasherized_val}"
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
              memo[:classes] << "flex-self-#{val}"
            elsif key == WIDTH_KEY || key == HEIGHT_KEY
              if val == :fit || val == :fill
                memo[:classes] << "#{key}-#{val}"
              else
                memo[key] = val
              end
            elsif TEXT_KEYS.include?(key)
              memo[:classes] << "text-#{dasherized_val}"
            elsif TYPOGRAPHY_KEYS.include?(key)
              memo[:classes] << "f#{dasherized_val}"
            elsif MARGIN_DIRECTION_KEYS.include?(key) && val < 0
              memo[:classes] << "#{key.to_s.dasherize}#{breakpoint}-n#{val.abs}"
            elsif key == BOX_SHADOW_KEY
              if val == true
                memo[:classes] << "box-shadow"
              else
                memo[:classes] << "box-shadow-#{dasherized_val}"
              end
            else
              memo[:classes] << "#{key.to_s.dasherize}#{breakpoint}-#{dasherized_val}"
            end
          end
        end

        {
          classes: out[:classes].join(" "),
          styles: out[:styles].join(" ")
        }.merge(out.except(:classes, :styles))
      end
    end
  end
end
