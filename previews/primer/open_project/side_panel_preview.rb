# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label SidePanel
    class SidePanelPreview < ViewComponent::Preview
      # @nodoc
      class MyComponent < ViewComponent::Base
        def call
          render(Primer::OpenProject::SidePanel::Section.new) do |section|
            section.with_title { "My custom component" }
            section.with_counter(count: 5)
            section.with_description do
              "Some text here"
            end

            section.with_action_icon(icon: :pencil, 'aria-label': 'Edit')
            section.with_footer_button(tag: :a, href: '#') do |button|
              button.with_leading_visual_icon(icon: :pencil)
              "Additional action"
            end

            "Section content"
          end
        end
      end

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
