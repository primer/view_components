# frozen_string_literal: true

require "rubocop"

# :nocov:
module RuboCop
  module Cop
    module Primer
      # This cop ensures that components don't use deprecated arguments
      #
      # bad
      # Component.new(foo: :deprecated)
      #
      # good
      # Component.new(foo: :bar)
      class DeprecatedArguments < BaseCop
        INVALID_MESSAGE = <<~STR
          Avoid using deprecated arguments: https://primer.style/view-components/deprecated.
        STR

        # This is a hash of deprecated arguments and their replacements.
        #
        #   * The top level key is the argument.
        #   * The second level key is the value.
        #   * The second level value is a string of the full replacement. e.g. "new_argument: :new_value"
        #     If the value is nil, then there is no replacement.
        #
        # e.g.
        # DEPRECATED = {
        #   argument: {
        #     value: "new_argument: :new_value"
        #   }
        # }
        #
        DEPRECATED = {
          bg: {
            white: "bg: :primary",
            gray_light: "bg: :secondary",
            gray: "bg: :tertiary",
            gray_dark: "bg: :canvas_inverse",
            blue_light: "bg: :info",
            blue: "bg: :info_inverse",
            green_light: "bg: :success",
            green: "bg: :success_inverse",
            yellow_light: "bg: :warning",
            yellow: "bg: :warning_inverse",
            red_light: "bg: :danger",
            red: "bg: :danger_inverse",
            canvas: "bg: :default",
            canvas_inverse: "bg: :emphasis",
            canvas_inset: "bg: :inset",
            primary: "bg: :default",
            secondary: "bg: :subtle",
            tertiary: "bg: :subtle",
            info: "bg: :accent",
            info_inverse: "bg: :accent_emphasis",
            danger_inverse: "bg: :danger_emphasis",
            success_inverse: "bg: :success_emphasis",
            warning: "bg: :attention",
            warning_inverse: "bg: :attention_emphasis",
            gray_0: nil,
            gray_1: nil,
            gray_2: nil,
            gray_3: nil,
            gray_4: nil,
            gray_5: nil,
            gray_6: nil,
            gray_7: nil,
            gray_8: nil,
            gray_9: nil,
            blue_0: nil,
            blue_1: nil,
            blue_2: nil,
            blue_3: nil,
            blue_4: nil,
            blue_5: nil,
            blue_6: nil,
            blue_7: nil,
            blue_8: nil,
            blue_9: nil,
            green_0: nil,
            green_1: nil,
            green_2: nil,
            green_3: nil,
            green_4: nil,
            green_5: nil,
            green_6: nil,
            green_7: nil,
            green_8: nil,
            green_9: nil,
            yellow_0: nil,
            yellow_1: nil,
            yellow_2: nil,
            yellow_3: nil,
            yellow_4: nil,
            yellow_5: nil,
            yellow_6: nil,
            yellow_7: nil,
            yellow_8: nil,
            yellow_9: nil,
            red_0: nil,
            red_1: nil,
            red_2: nil,
            red_3: nil,
            red_4: nil,
            red_5: nil,
            red_6: nil,
            red_7: nil,
            red_8: nil,
            red_9: nil,
            purple_0: nil,
            purple_1: nil,
            purple_2: nil,
            purple_3: nil,
            purple_4: nil,
            purple_5: nil,
            purple_6: nil,
            purple_7: nil,
            purple_8: nil,
            purple_9: nil,
            pink_0: nil,
            pink_1: nil,
            pink_2: nil,
            pink_3: nil,
            pink_4: nil,
            pink_5: nil,
            pink_6: nil,
            pink_7: nil,
            pink_8: nil,
            pink_9: nil,
            orange_0: nil,
            orange_1: nil,
            orange_2: nil,
            orange_3: nil,
            orange_4: nil,
            orange_5: nil,
            orange_6: nil,
            orange_7: nil,
            orange_8: nil,
            orange_9: nil,
            purple_light: nil,
            purple: nil,
            yellow_dark: nil,
            orange: nil,
            pink: nil
          },
          border_color: {
            gray: "border_color: :primary",
            gray_light: "border_color: :secondary",
            gray_dark: "border_color: :tertiary",
            blue: "border_color: :info",
            green: "border_color: :success",
            yellow: "border_color: :warning",
            red: "border_color: :danger",
            white: "border_color: :inverse",
            primary: "border_color: :default",
            secondary: "border_color: :muted",
            tertiary: "border_color: :default",
            inverse: nil,
            info: "border_color: :accent_emphasis",
            warning: "border_color: :attention_emphasis"
          },
          color: {
            text_primary: "color: :default",
            text_secondary: "color: :muted",
            text_tertiary: "color: :muted",
            text_link: "color: :accent",
            text_success: "color: :success",
            text_warning: "color: :attention",
            text_danger: "color: :danger",
            text_inverse: "color: :on_emphasis",
            text_white: "color: :on_emphasis",
            icon_primary: "color: :default",
            icon_secondary: "color: :muted",
            icon_tertiary: "color: :muted",
            icon_info: "color: :accent",
            icon_danger: "color: :danger",
            icon_success: "color: :success",
            icon_warning: "color: :attention",
            blue: "color: :text_link",
            gray_dark: "color: :text_primary",
            gray: "color: :text_secondary",
            gray_light: "color: :text_tertiary",
            green: "color: :text_success",
            yellow: "color: :text_warning",
            red: "color: :text_danger",
            gray_0: nil,
            gray_1: nil,
            gray_2: nil,
            gray_3: nil,
            gray_4: nil,
            gray_5: nil,
            gray_6: nil,
            gray_7: nil,
            gray_8: nil,
            gray_9: nil,
            blue_0: nil,
            blue_1: nil,
            blue_2: nil,
            blue_3: nil,
            blue_4: nil,
            blue_5: nil,
            blue_6: nil,
            blue_7: nil,
            blue_8: nil,
            blue_9: nil,
            green_0: nil,
            green_1: nil,
            green_2: nil,
            green_3: nil,
            green_4: nil,
            green_5: nil,
            green_6: nil,
            green_7: nil,
            green_8: nil,
            green_9: nil,
            yellow_0: nil,
            yellow_1: nil,
            yellow_2: nil,
            yellow_3: nil,
            yellow_4: nil,
            yellow_5: nil,
            yellow_6: nil,
            yellow_7: nil,
            yellow_8: nil,
            yellow_9: nil,
            red_0: nil,
            red_1: nil,
            red_2: nil,
            red_3: nil,
            red_4: nil,
            red_5: nil,
            red_6: nil,
            red_7: nil,
            red_8: nil,
            red_9: nil,
            purple_0: nil,
            purple_1: nil,
            purple_2: nil,
            purple_3: nil,
            purple_4: nil,
            purple_5: nil,
            purple_6: nil,
            purple_7: nil,
            purple_8: nil,
            purple_9: nil,
            pink_0: nil,
            pink_1: nil,
            pink_2: nil,
            pink_3: nil,
            pink_4: nil,
            pink_5: nil,
            pink_6: nil,
            pink_7: nil,
            pink_8: nil,
            pink_9: nil,
            orange_0: nil,
            orange_1: nil,
            orange_2: nil,
            orange_3: nil,
            orange_4: nil,
            orange_5: nil,
            orange_6: nil,
            orange_7: nil,
            orange_8: nil,
            orange_9: nil
          }
        }.freeze

        def on_send(node)
          return unless valid_node?(node)
          return unless node.arguments?

          # we are looking for hash arguments and they are always last
          kwargs = node.arguments.last

          return unless kwargs.type == :hash

          kwargs.pairs.each do |pair|
            # Skip if we're not dealing with a symbol key
            next if pair.key.type != :sym

            key, value = extract_kv_from(pair)
            next unless DEPRECATED.key?(key) && DEPRECATED[key].key?(value)

            add_offense(pair, message: INVALID_MESSAGE)
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            key, value = extract_kv_from(node)
            replacement = DEPRECATED[key][value]
            corrector.replace(node, replacement) if replacement.present?
          end
        end

        def extract_kv_from(pair)
          key = pair.key.value

          value = case pair.value.type
                  when :sym, :str
                    pair.value.value.to_sym
                  when :false, :true
                    pair.value.type == :true
                  else
                    return []
                  end

          [key, value]
        end
      end
    end
  end
end
