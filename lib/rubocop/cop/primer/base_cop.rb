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
          return false if node.nil?

          view_helpers.include?(node.method_name) || (node.method_name == :new && !node.receiver.nil? && ::Primer::ViewComponents::STATUSES.key?(node.receiver.const_name))
        end

        private

        def view_helpers
          ::Primer::ViewHelper::HELPERS.keys.map { |key| "primer_#{key}".to_sym }
        end
      end
    end
  end
end
