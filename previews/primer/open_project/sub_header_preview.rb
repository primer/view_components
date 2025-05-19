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
      # @param show_clear_button toggle
      # @param text text
      # @param value text
      def playground(
        show_filter_input: true,
        show_clear_button: true,
        show_filter_button: true,
        show_action_button: true,
        text: nil,
        value: nil
      )
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(
            name: "filter",
            label: "Filter",
            show_clear_button: show_clear_button,
            value: value) if show_filter_input
          component.with_filter_button do |button|
            button.with_trailing_visual_counter(count: "15")
            "Filter"
          end if show_filter_button

          component.with_text { text } unless text.nil?

          component.with_action_button(leading_icon: :plus, label: "Create", scheme: :primary) do
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

          component.with_action_button(leading_icon: :plus, label: "Create", scheme: :primary) do
            "Create"
          end
        end
      end

      # @label With ActionMenu
      def action_menu_buttons
        render_with_template(locals: {})
      end

      # @label With Dialog
      # Only async dialogs are supported in the SubHeader.
      # Since we duplicate the buttons for mobile purposes,
      # the dialog would otherwise be duplicated (with the same ID) as well
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

      # @label With SegmentedControl
      def segmented_control
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_button do |button|
            button.with_trailing_visual_counter(count: "15")
            "Filter"
          end

          component.with_segmented_control("aria-label": "Segmented control") do |control|
            control.with_item(tag: :a, href: "#", label: "Preview", icon: :eye, selected: true)
            control.with_item(tag: :a, href: "#", label: "Raw", icon: :"file-code")
          end

          component.with_action_button(leading_icon: :plus, label: "Create", scheme: :primary) do
            "Create"
          end
        end
      end

      # @label With a custom area below
      def bottom_pane
        render_with_template(locals: {})
      end

      # @label With Text in the middle
      def text
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(name: "filter", label: "Filter")

          component.with_text { "Hello world!" }

          component.with_action_button(leading_icon: :plus, label: "Create", scheme: :primary) do
            "Create"
          end
        end
      end
    end
  end
end
