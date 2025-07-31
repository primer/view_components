# frozen_string_literal: true

module Primer
  module Alpha
    class TreeView
      # Renders a loading spinner for a `TreeView` sub-tree node.
      #
      # This component is part of the <%= link_to_component(Primer::Alpha::TreeView) %> component and should
      # not be used directly.
      class SpinnerLoader < Primer::Component
        # The failure message that appears if loading nodes from the server fails.
        #
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::TreeView::LoadingFailureMessage) %>.
        renders_one :loading_failure_message, lambda { |**system_arguments|
          system_arguments[:retry_button_arguments] ||= {}
          system_arguments[:retry_button_arguments][:data] = merge_data(
            system_arguments[:retry_button_arguments],
            data: { target: "tree-view-sub-tree-node.retryButton" }
          )

          LoadingFailureMessage.new(**system_arguments)
        }

        # @param src [String] The URL to fetch nodes from.
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::TreeView::SubTreeContainer) %>.
        def initialize(src:, **system_arguments)
          @src = src
          @container = SubTreeContainer.new(**system_arguments, expanded: true)
        end
      end
    end
  end
end
