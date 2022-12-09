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
          component_name = node.receiver.const_name
          return unless node.method_name == :new && !node.receiver.nil? && ::Primer::Deprecations.deprecated?(component_name)

          add_offense(node.receiver, message: ::Primer::Deprecations.deprecation_message(component_name))
        end

        def autocorrect(node)
          lambda do |corrector|
            component_name = node.const_name
            return unless ::Primer::Deprecations.correctable?(component_name)

            replacement = ::Primer::Deprecations.replacement(component_name)
            corrector.replace(node, replacement) if replacement.present?
          end
        end
      end
    end
  end
end
