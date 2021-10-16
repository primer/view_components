# frozen_string_literal: true

require "rubocop"
require "primer/view_components/statuses"
require_relative "../../../../app/lib/primer/view_helper"

module RuboCop
  module Cop
    module Primer
      # :nodoc:
      class BaseCop < RuboCop::Cop::Cop
        # We only verify SystemArguments if it's a `.new` call on a component or
        # a ViewHeleper call.
        def valid_node?(node)
          return if node.nil?

          view_helpers.include?(node.method_name) || (node.method_name == :new && !node.receiver.nil? && ::Primer::ViewComponents::STATUSES.key?(node.receiver.const_name))
        end

        def add_offense(node_or_range, message: nil, severity: nil, &block)
          range = range_from_node_or_range(node_or_range)
          return unless enabled_line?(range.line)

          super(node_or_range, message: message, severity: severity, &block)
        end

        private

        def view_helpers
          ::Primer::ViewHelper::HELPERS.keys.map { |key| "primer_#{key}".to_sym }
        end
      end
    end
  end
end
