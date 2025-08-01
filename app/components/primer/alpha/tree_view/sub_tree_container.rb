# frozen_string_literal: true

module Primer
  module Alpha
    class TreeView
      # This component is part of the <%= link_to_component(Primer::Alpha::TreeView) %> component and should
      # not be used directly.
      class SubTreeContainer < Primer::Component
        # The path to this node
        #
        # @return [Array<String>]
        attr_reader :path

        # Whether or not this sub-tree node renders expanded.
        #
        # @return [Boolean]
        attr_reader :expanded

        alias expanded? expanded

        # @param path [Array<String>] The path to this node.
        # @param expanded [Boolean] Whether or not this sub-tree node renders expanded.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(path:, expanded: false, **system_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @path = path
          @expanded = expanded

          @system_arguments[:tag] = :ul
          @system_arguments[:role] = :group
          @system_arguments[:p] = 0
          @system_arguments[:m] = 0
          @system_arguments[:style] = "list-style: none;"
          @system_arguments[:hidden] = !expanded?
        end
      end
    end
  end
end
