# frozen_string_literal: true

module RuboCop
  module Cop
    module Migrations
      # Lint and hopefully autocorrect cases of the deprecated ButtonComponent
      class ButtonComponent < RuboCop::Cop::Cop
        INVALID_MESSAGE = <<~STR
          `Primer::ButtonComponent` is deprecated. Please use `Primer::Beta::Button` instead.
        STR

        def_node_matcher :button_component, <<~PATTERN
          (send $(const (const nil? :Primer) :ButtonComponent) :new ...)
        PATTERN

        def_node_matcher :hash_with_dropdown_value?, <<~PATTERN
          (hash ... (pair (sym :dropdown) (...)) ... )
        PATTERN

        def_node_matcher :hash_with_group_item_value?, <<~PATTERN
          (hash ... (pair (sym :group_item) (...)) ... )
        PATTERN

        def_node_matcher :hash_with_variant_value, <<~PATTERN
          (hash ... (pair $(sym :variant) (...)) ... )
        PATTERN

        def_node_matcher :hash_with_scheme_outline_value, <<~PATTERN
          (hash ... (pair (sym :scheme) $(...)) ... )
        PATTERN

        def on_send(node)
          return unless button_component(node)

          add_offense(node, message: INVALID_MESSAGE)
        end

        def autocorrect(node)
          return if hash_with_dropdown_value?(node.arguments.first)
          return if hash_with_group_item_value?(node.arguments.first)

          lambda do |corrector|
            corrector.replace(button_component(node), "Primer::Beta::Button")

            variant = hash_with_variant_value(node.arguments.first)
            corrector.replace(variant, "size") if variant.present?

            scheme_outline = hash_with_scheme_outline_value(node.arguments.first)
            corrector.replace(scheme_outline, ":invisible") if scheme_outline&.value == :outline
          end
        end
      end
    end
  end
end
