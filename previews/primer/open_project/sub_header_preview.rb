# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label SubHeader
    class SubHeaderPreview < ViewComponent::Preview
      # @label Playground
      # @param show_filter_input toggle
      # @param show_filter_button toggle
      # @param show_action_button toggle
      # @param text text
      def playground(show_filter_input: true, show_filter_button: true, show_action_button: true, text: nil)
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(name: "filter", label: "Filter") if show_filter_input
          component.with_filter_button do |button|
            button.with_trailing_visual_counter(count: "15")
            "Filter"
          end if show_filter_button

          component.with_text { text } unless text.nil?

          component.with_action_button(scheme: :primary) do |button|
              button.with_leading_visual_icon(icon: :plus)
              "Create"
          end if show_action_button
        end
      end

      # @label Default
      def default
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(name: "filter", label: "Filter")
          component.with_filter_button do |button|
            button.with_trailing_visual_counter(count: "15")
            "Filter"
          end

          component.with_action_button(scheme: :primary)  do |button|
            button.with_leading_visual_icon(icon: :plus)
            "Create"
          end
        end
      end

      # @label With ActionMenu
      def action_menu_buttons
        render_with_template(locals: {})
      end

      # @label With Dialog
      def dialog_buttons
        render_with_template(locals: {})
      end

      # @label With ButtonGroup
      def button_group
        render_with_template(locals: {})
      end

      # @label With custom filter button
      def custom_filter_button
        render_with_template(locals: {})
      end

      # @label With Text in the middle
      def text
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(name: "filter", label: "Filter")

          component.with_text { "Hello world!" }

          component.with_action_button(scheme: :primary)  do |button|
            button.with_leading_visual_icon(icon: :plus)
            "Create"
          end
        end
      end
    end
  end
end
