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
        def on_send(node)
          return unless node.method_name == :new && !node.receiver.nil? && ::Primer::Deprecations.deprecated?(node.receiver.const_name)

          add_offense(node.receiver, message: "Don't use deprecated names")
        end

        def autocorrect(node)
          lambda do |corrector|
            component_name = node.const_name
            return unless ::Primer::Deprecations.correctable?(component_name)

            suggested_component = ::Primer::Deprecations.suggested_component(component_name)
            corrector.replace(node, suggested_component) if suggested_component.present?
          end
        end
      end
    end
  end
end
