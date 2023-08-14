# frozen_string_literal: true

module RuboCop
  module Cop
    module Migrations
      # Lint & autocorrect Truncate components
      class TruncateComponent < RuboCop::Cop::Cop
        INVALID_MESSAGE = <<~STR
          `Primer::Truncate` is deprecated. Please use `Primer::Beta::Truncate` instead!
        STR

        def_node_matcher :truncate_component, <<~PATTERN
          (send (const (const nil? :Primer) :Truncate) :new ...)
        PATTERN

        def_node_matcher :hash_with_inline_value?, <<~PATTERN
          (hash ... (pair (sym :inline) (...)) ... )
        PATTERN

        def_node_matcher :truncate_with_tag?, <<~PATTERN
          (hash ... (pair (sym :tag) (...)) ... )
        PATTERN

        def on_send(node)
          return unless truncate_component(node)

          add_offense(node, message: INVALID_MESSAGE)
        end

        def autocorrect(node)
          return if hash_with_inline_value?(node.arguments.first)

          lambda do |corrector|
            if node.arguments.first.nil? == false
              corrector.replace(node.children.first, "Primer::Beta::Truncate")
              corrector.insert_after(node.arguments.first, ", tag: :div") unless truncate_with_tag?(node.arguments.first)
            else
              corrector.replace(node.loc.expression, "Primer::Beta::Truncate.new(tag: :div)")
            end
          end
        end
      end
    end
  end
end
