# frozen_string_literal: true

require "rubocop"

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
        DEPRECATIONS = {
          "Primer::PopoverComponent" => "Primer::Beta::Popover"
        }.freeze

        def on_send(node)
          return unless node.method_name == :new && !node.receiver.nil? && DEPRECATIONS.key?(node.receiver.const_name)

          add_offense(node.receiver, message: "Don't use deprecated names")
        end

        def autocorrect(node)
          lambda do |corrector|
            corrector.replace(node, DEPRECATIONS[node.const_name])
          end
        end
      end
    end
  end
end
