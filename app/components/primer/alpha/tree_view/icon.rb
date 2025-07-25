# frozen_string_literal: true

module Primer
  module Alpha
    class TreeView
      # An icon for a `TreeView` node.
      #
      # This component is part of the <%= link_to_component(Primer::Alpha::TreeView) %> component and should
      # not be used directly.
      class Icon < Primer::Component
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Octicon) %>.
        def initialize(**system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:focusable] = "false"
          @system_arguments[:display] = :inline_block
          @system_arguments[:overflow] = :visible
          @system_arguments[:style] = "vertical-align: text-bottom;"
        end
      end
    end
  end
end
