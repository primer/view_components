# frozen_string_literal: true

require "rubocop"
require "primer/classify/utilities"
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

        def on_send(node)
          return unless valid_node?(node)
          return unless node.arguments?

          # we are looking for hash arguments and they are always last
          kwargs = node.arguments.last

          return unless kwargs.type == :hash

          @deprecated_arguments = cop_config["Deprecated"] || {}

          kwargs.pairs.each do |pair|
            # Skip if we're not dealing with a symbol
            next if pair.key.type != :sym
            next if pair.value.type != :sym

            key = pair.key.value
            value = pair.value.value
            next unless @deprecated_arguments.key?(key) && @deprecated_arguments[key].key?(value)

            add_offense(pair, message: INVALID_MESSAGE)
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            replacement = @deprecated_arguments[node.key.value][node.value.value]
            corrector.replace(node, "#{node.key.value}: #{replacement}") if replacement.present?
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
