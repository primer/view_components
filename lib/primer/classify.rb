# frozen_string_literal: true

module Primer
  class Classify
    MARGIN_DIRECTION_KEYS = [:mt, :ml, :mb, :mr]
    SPACING_KEYS = ([:m, :my, :mx, :p, :py, :px, :pt, :pl, :pb, :pr] + MARGIN_DIRECTION_KEYS).freeze
    DIRECTION_KEY = :direction
    JUSTIFY_CONTENT_KEY = :justify_content
    ALIGN_ITEMS_KEY = :align_items
    DISPLAY_KEY = :display
    RESPONSIVE_KEYS = ([DISPLAY_KEY, DIRECTION_KEY, JUSTIFY_CONTENT_KEY, ALIGN_ITEMS_KEY, :col] + SPACING_KEYS).freeze
    BREAKPOINTS = ["", "-sm", "-md", "-lg"]

    # Keys where we can simply translate { key: value } into ".key-value"
    CONCAT_KEYS = SPACING_KEYS + [:hide, :position, :v, :float, :col, :text].freeze

    INVALID_CLASS_NAME_PREFIXES =
      (["bg-", "color-", "text-", "d-", "v-align-", "wb-", "text-"] + CONCAT_KEYS.map { |k| "#{k}-" }).freeze

    COLOR_KEY = :color
    BG_KEY = :bg
    VERTICAL_ALIGN_KEY = :vertical_align
    WORD_BREAK_KEY = :word_break
    TEXT_KEYS = [:text_align, :font_weight]

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
        ALIGN_ITEMS_KEY
      ]
    ).freeze

    class << self
      def call(classes: "", **args)
        [validated_class_names(classes), classes_from_hash(args)].compact.join(" ").presence
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
              not allowed, use hash syntax instead. This warning will not be raised in production.",
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
      # classes_from_hash({ mt: 4, py: 2 }) => "mt-4 py-2"
      def classes_from_hash(styles_hash)
        styles_hash.each_with_object([]) do |(key, value), memo|
          next unless VALID_KEYS.include?(key)

          if value.is_a?(Array) && !RESPONSIVE_KEYS.include?(key)
            raise ArgumentError, "#{key} does not support responsive values"
          end

          Array(value).each_with_index do |val, index|
            next if val.nil?

            if SPACING_KEYS.include?(key)
              if MARGIN_DIRECTION_KEYS.include?(key)
                raise ArgumentError, "value must be between -6 and 6" if (val < -6 || val > 6)
              else
                raise ArgumentError, "value must be between 0 and 6" if (val < 0 || val > 6)
              end
            end

            dasherized_val = val.to_s.dasherize
            breakpoint = BREAKPOINTS[index]

            if BOOLEAN_MAPPINGS.has_key?(key)
              BOOLEAN_MAPPINGS[key][:mappings].map { |m| m[:css_class] if m[:value] == val }.compact.each do |css_class|
                memo << css_class
              end
            elsif key == BG_KEY
              memo << "bg-#{dasherized_val}"
            elsif key == COLOR_KEY
              if val.to_s.chars.last !~ /\D/
                memo << "color-#{dasherized_val}"
              else
                memo << "text-#{dasherized_val}"
              end
            elsif key == DISPLAY_KEY
              memo << "d#{breakpoint}-#{dasherized_val}"
            elsif key == VERTICAL_ALIGN_KEY
              memo << "v-align-#{dasherized_val}"
            elsif key == WORD_BREAK_KEY
              memo << "wb-#{dasherized_val}"
            elsif BORDER_KEYS.include?(key)
              memo << "border-#{dasherized_val}"
            elsif key == DIRECTION_KEY
              memo << "flex#{breakpoint}-#{dasherized_val}"
            elsif key == JUSTIFY_CONTENT_KEY
              formatted_value = val.to_s.gsub(/(flex\_|space\_)/, "")
              memo << "flex#{breakpoint}-justify-#{formatted_value}"
            elsif key == ALIGN_ITEMS_KEY
              memo << "flex#{breakpoint}-items-#{val.to_s.gsub("flex_", "")}"
            elsif TEXT_KEYS.include?(key)
              memo << "text-#{dasherized_val}"
            elsif TYPOGRAPHY_KEYS.include?(key)
              memo << "f#{dasherized_val}"
            elsif MARGIN_DIRECTION_KEYS.include?(key) && val < 0
              memo << "#{key.to_s.dasherize}#{breakpoint}-n#{val.abs}"
            else
              memo << "#{key.to_s.dasherize}#{breakpoint}-#{dasherized_val}"
            end
          end
        end.join(" ")
      end
    end
  end
end
