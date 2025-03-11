# frozen_string_literal: true

require "rubocop"

# :nocov:
module RuboCop
  module Cop
    module Primer
      # This cop ensures that `ButtonComponent` doesn't use deprecated arguments.
      #
      # bad
      # ButtonComponent.new(variant: :small)
      #
      # good
      # ButtonComponent.new(size: :small)
      class DeprecatedButtonArguments < BaseCop
        extend AutoCorrector

        INVALID_MESSAGE = <<~STR
          `variant` is deprecated. Use `size` instead.
        STR

        def_node_matcher :button_component?, <<~PATTERN
          (send (const (const nil? :Primer) :ButtonComponent) :new ...)
        PATTERN

        DEPRECATIONS = {
          variant: :size
        }.freeze

        def on_send(node)
          return unless button_component?(node)

          kwargs = node.arguments.last

          return if kwargs.nil?

          pair = kwargs.pairs.find { |x| x.key.value == :variant }

          return if pair.nil?

          add_offense(pair.key, message: INVALID_MESSAGE) do |corrector|
            corrector.replace(node, DEPRECATIONS[node.value])
          end
        end
      end
    end
  end
end
