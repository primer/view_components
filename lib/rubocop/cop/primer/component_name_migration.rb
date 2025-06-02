# frozen_string_literal: true

require "rubocop"
require "primer/deprecations"

# :nocov:
module RuboCop
  module Cop
    module Primer
      # This cop ensures that components don't use deprecated component names
      #
      # bad
      # Primer::ComponentNameComponent.new()
      #
      # good
      # Primer::Beta::ComponentName.new()
      class ComponentNameMigration < BaseCop
        extend AutoCorrector

        def on_send(node)
          return unless node.method_name == :new && !node.receiver.nil? && ::Primer::Deprecations.deprecated?(node.receiver.const_name)

          message = ::Primer::Deprecations.deprecation_message(node.receiver.const_name)
          
          add_offense(node.receiver, message: message) do |corrector|
            component_name = node.receiver.const_name
            next unless ::Primer::Deprecations.correctable?(component_name)

            replacement = ::Primer::Deprecations.replacement(component_name)
            corrector.replace(node.receiver, replacement) if replacement.present?
          end
        end
      end
    end
  end
end
