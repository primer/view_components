# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label SidePanel
    class SidePanelPreview < ViewComponent::Preview
      # @label Playground
      # @param description text
      # @param show_description toggle
      # @param show_action toggle
      # @param show_footer_action toggle
      # @param counter number
      def playground(description: "Some information", counter: 12, show_description: true, show_action: true, show_footer_action: true)
        render_with_template(
          locals: {
            description: description,
            counter: counter,
            show_description: show_description,
            show_action: show_action,
            show_footer_action: show_footer_action
          }
        )
      end

      # @label Default
      def default
      end

      # @label With custom component
      def with_component
      end
    end
  end
end
