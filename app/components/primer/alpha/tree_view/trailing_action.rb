# frozen_string_literal: true

module Primer
  module Alpha
    class TreeView
      # The trailing action for `TreeView` nodes.
      #
      # This component is part of the <%= link_to_component(Primer::Alpha::TreeView) %> component and should
      # not be used directly.
      class TrailingAction < Primer::Component
        # @param action [ViewComponent::Base] A component or other renderable to use as the action button etc.
        def initialize(action:)
          @action = action
        end
      end
    end
  end
end
