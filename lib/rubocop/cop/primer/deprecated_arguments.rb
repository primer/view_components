# frozen_string_literal: true

require "rubocop"
require "primer/view_components/statuses"
require_relative "../../../../app/lib/primer/view_helper"

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
      class DeprecatedArguments < RuboCop::Cop::Cop
        INVALID_MESSAGE = <<~STR
          Avoid using deprecated arguments: https://primer.style/view-components/deprecated.
        STR

        # This is a hash of deprecated arguments and their replacements.
        #
        #   * The top level key is the argument.
        #   * The second level key is the value.
        #   * The seceond level value is a string of the full replacement. e.g. "new_argument: :new_value"
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
          },
          border_color: {
            gray: "border_color: :primary",
            gray_light: "border_color: :secondary",
            gray_dark: "border_color: :tertiary",
            blue: "border_color: :info",
            green: "border_color: :success",
            yellow: "border_color: :warning",
            red: "border_color: :danger",
            white: "border_color: :inverse"
          },
          color: {
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
            # Skip if we're not dealing with a symbol
            next if pair.key.type != :sym
            next unless pair.value.type == :sym || pair.value.type == :str

            key = pair.key.value
            value = pair.value.value.to_sym

            next unless DEPRECATED.key?(key) && DEPRECATED[key].key?(value)

            add_offense(pair, message: INVALID_MESSAGE)
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            replacement = DEPRECATED[node.key.value][node.value.value.to_sym]
            corrector.replace(node, replacement) if replacement.present?
          end
        end

        private

        # We only verify SystemArguments if it's a `.new` call on a component or
        # a ViewHleper call.
        def valid_node?(node)
          view_helpers.include?(node.method_name) || (node.method_name == :new && ::Primer::ViewComponents::STATUSES.key?(node.receiver.const_name))
        end

        def view_helpers
          ::Primer::ViewHelper::HELPERS.keys.map { |key| "primer_#{key}".to_sym }
        end
      end
    end
  end
end
