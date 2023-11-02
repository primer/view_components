# frozen_string_literal: true

require "rubocop"

# :nocov:
module RuboCop
  module Cop
    module Primer
      # This cop ensures that `LabelComponent`s don't use the old `variant` argument.
      #
      # bad
      # Primer::Beta::Label.new(variant: :large)
      #
      # good
      # Primer::Beta::Label.new(size: :large)
      #
      # bad
      # Primer::Beta::Label.new(variant: :inline)
      #
      # good
      # Primer::Beta::Label.new(inline: true)
      class DeprecatedLabelVariants < BaseCop
        def on_send(node)
          return unless label_node?(node)
          return unless node.arguments?

          # we are looking for hash arguments and they are always last
          kwargs = node.arguments.last

          return unless kwargs.type == :hash

          kwargs.pairs.each do |pair|
            # skip if we're not dealing with a symbol or string
            next if pair.key.type != :sym
            next unless pair.value.type == :sym || pair.value.type == :str
            next if pair.key.value != :variant

            case pair.value.value
            when :large, "large"
              add_offense(pair, message: "Avoid using `variant: :large` with `LabelComponent`. Use `size: :large` instead.")
            when :inline, "inline"
              add_offense(pair, message: "Avoid using `variant: :inline` with `LabelComponent`. Use `inline: true` instead.")
            end
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            replacement =
              case node.value.value
              when :large, "large"
                "size: :large"
              when :inline, "inline"
                "inline: true"
              end

            corrector.replace(node, replacement)
          end
        end

        private

        def label_node?(node)
          return false if node.nil?

          node.method_name == :new && !node.receiver.nil? && node.receiver.const_name == "Primer::Beta::Label"
        end
      end
    end
  end
end
