# frozen_string_literal: true

module RuboCop
  module Cop
    module Migrations
      # Lint and autocorrect deprecated IconButton
      class IconButtonComponent < RuboCop::Cop::Cop
        INVALID_MESSAGE = <<~STR
          `Primer::IconButton` is deprecated. Please use `Primer::Beta::IconButton` instead.
        STR

        def_node_matcher :icon_button, <<~PATTERN
          (send $(const (const nil? :Primer) :IconButton) :new ...)
        PATTERN

        def_node_matcher :hash_with_box_value?, <<~PATTERN
          (hash ... (pair (sym :box) (...)) ... )
        PATTERN

        def on_send(node)
          return unless icon_button(node)

          add_offense(node, message: INVALID_MESSAGE)
        end

        def autocorrect(node)
          return if hash_with_box_value?(node.arguments.first)

          lambda do |corrector|
            corrector.replace(icon_button(node), "Primer::Beta::IconButton")
          end
        end
      end
    end
  end
  end
