# frozen_string_literal: true

module Primer
  module Alpha
    class TreeView
      # A `TreeView` visual, either leading or trailing.
      #
      # This component is part of the <%= link_to_component(Primer::Alpha::TreeView) %> component and should
      # not be used directly.
      class Visual < Primer::Component
        # @param id [String] This visual's HTML ID.
        # @param visual [ViewComponent::Base] A renderable component like an instance of <%= link_to_component(Primer::Beta::Octicon) %> to render as the visual.
        # @param label [String] Text describing this visual that will be visible only to screen readers.
        def initialize(id:, visual:, label: nil)
          @id = id
          @visual = visual
          @label = label
        end

        def render_in(_view_context, &block)
          block&.call(@visual)
          super
        end
      end
    end
  end
end
