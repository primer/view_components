# frozen_string_literal: true

module Primer
  module OpenProject
    class TreeView
      # A pair of icons for a `TreeView` sub-tree that displays distinct icons when the sub-tree is
      # expanded and collapsed.
      #
      # This component is part of the <%= link_to_component(Primer::OpenProject::TreeView) %> component and should
      # not be used directly.
      class IconPair < Primer::Component
        # The expanded icon.
        #
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::OpenProject::TreeView::Icon) %>.
        renders_one :expanded_icon, lambda { |**system_arguments|
          Icon.new(**system_arguments)
        }

        # The collapsed icon.
        #
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::OpenProject::TreeView::Icon
        renders_one :collapsed_icon, lambda { |**system_arguments|
          Icon.new(**system_arguments)
        }

        # Whether or not this icon is expanded.
        #
        # @return [Boolean]
        attr_reader :expanded
        alias expanded? expanded

        # @param expanded [Boolean] If true, the expanded icon is shown and the collapsed icon is hidden, etc.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(expanded: false, **system_arguments)
          @expanded = expanded
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :"tree-view-icon-pair"
        end
      end
    end
  end
end
