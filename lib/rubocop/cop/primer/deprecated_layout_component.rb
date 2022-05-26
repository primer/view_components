# frozen_string_literal: true

require "rubocop"

module RuboCop
  module Cop
    module Primer
      # This cop ensures that the deprecated `Primer::LayoutComponent` isn't used.
      #
      # bad
      # Primer::LayoutComponent.new(foo: :deprecated)
      #
      # good
      # Primer::Alpha::Layout.new(foo: :deprecated)
      class DeprecatedLayoutComponent < BaseCop
        MSG = "Please try Primer::Alpha::Layout instead."

        def_node_matcher :legacy_component?, <<~PATTERN
          (send (const (const nil? :Primer) :LayoutComponent) :new ...)
        PATTERN

        def on_send(node)
          return unless legacy_component?(node)

          add_offense(node, message: MSG)
        end
      end
    end
  end
end
