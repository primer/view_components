# frozen_string_literal: true

require "rubocop"

# :nocov:
module RuboCop
  module Cop
    module Primer
      # This cop ensures that components don't use deprecated `Label` schemes.
      #
      # bad
      # Primer::Beta::Label.new(scheme: :info)
      #
      # good
      # Primer::Beta::Label.new(scheme: :accent)
      class DeprecatedLabelSchemes < BaseCop
        INVALID_MESSAGE = <<~STR
          Avoid using deprecated schemes: https://primer.style/view-components/deprecated#labelcomponent.
        STR

        # This is a hash of deprecated schemes and their replacements.
        DEPRECATIONS = {
          info: ":accent",
          warning: ":attention",
          orange: ":severe",
          purple: ":done"
        }.freeze

        def on_send(node)
          return unless label_node?(node)
          return unless node.arguments?

          # we are looking for hash arguments and they are always last
          kwargs = node.arguments.last

          return unless kwargs.type == :hash

          kwargs.pairs.each do |pair|
            # Skip if we're not dealing with a symbol
            next if pair.key.type != :sym
            next unless pair.value.type == :sym || pair.value.type == :str

            value = pair.value.value.to_sym

            next unless DEPRECATIONS.key?(value)

            add_offense(pair.value, message: INVALID_MESSAGE)
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            replacement = DEPRECATIONS[node.value.to_sym]
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
