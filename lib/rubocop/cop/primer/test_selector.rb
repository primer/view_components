# frozen_string_literal: true

require "rubocop"

# :nocov:
module RuboCop
  module Cop
    module Primer
      # Prefer the `test_selector` argument over manually generating
      # a `data-test-selector` attribute.
      #
      # Bad:
      #
      # Primer::BaseComponent.new(data: { "test-selector": "the-component" })
      #
      # Good:
      #
      # Primer::BaseComponent.new(test_selector: "the-component")
      class TestSelector < BaseCop
        INVALID_MESSAGE = <<~STR
          Prefer the `test_selector` argument over manually generating a `data-test-selector` attribute: https://primer.style/view-components/system-arguments.
        STR

        def on_send(node)
          return unless valid_node?(node)
          return unless node.arguments?

          kwargs = node.arguments.last
          return unless kwargs.type == :hash

          data_arg = kwargs.pairs.find { |kwarg| kwarg.key.value == :data }
          return if data_arg.nil?
          return unless data_arg.value.type == :hash

          hash = data_arg.child_nodes.find { |arg| arg.type == :hash }
          return unless hash

          test_selector = hash.pairs.find do |pair|
            pair.key.value == :"test-selector" || pair.key.value == "test-selector"
          end
          return unless test_selector

          add_offense(data_arg, message: INVALID_MESSAGE)
        end
      end
    end
  end
end
