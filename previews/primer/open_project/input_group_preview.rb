# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label InputGroup
    class InputGroupPreview < ViewComponent::Preview
      # @label Default
      # @snapshot
      def default
        render(Primer::OpenProject::InputGroup.new) do |menu|
          menu.with_text_input(name: 'a name', label: 'My input group', value: "Copyable value")
          menu.with_trailing_action_clipboard_copy_button(id: "button", value: "Copyable value", aria: { label: "Copy some text" })
        end
      end

      # @label Playground
      # @param trailing_action [Symbol] select [clipboardCopy, icon]
      # @param value [String]
      # @param visually_hide_label toggle
      # @param readonly toggle
      # @param input_width [Symbol] select [auto, small, medium, large, xlarge, xxlarge]
      def playground(
        trailing_action: :clipboardCopy,
        value: 'Copyable value',
        visually_hide_label: false,
        readonly: true,
        input_width: :medium
      )
        render(Primer::OpenProject::InputGroup.new(input_width: input_width)) do |menu|
          menu.with_text_input(name: 'Test', label: 'My input group', visually_hide_label: visually_hide_label, value: value, readonly: readonly)

          case trailing_action
          when :icon
            menu.with_trailing_action_icon(icon: :check, aria: { label: "Successful" })
          when :clipboardCopy
            menu.with_trailing_action_clipboard_copy_button(id: "button-2", value: value, aria: { label: "Copy some text" })
          else
            menu.with_trailing_action_clipboard_copy_button(id: "button-3", value: value, aria: { label: "Copy some text" })
          end
        end
      end

      # @label With icon button
      def icon_button
        render(Primer::OpenProject::InputGroup.new) do |menu|
          menu.with_text_input(name: 'a name', label: 'My input group', value: "Some value")
          menu.with_trailing_action_icon(icon: :check, aria: { label: "Successful" })
        end
      end

      # @label With a small input
      def small_input_width
        render(Primer::OpenProject::InputGroup.new(input_width: :small)) do |menu|
          menu.with_text_input(name: 'a name', label: 'My input group', value: "Some value")
          menu.with_trailing_action_clipboard_copy_button(id: "button-4", value: "Some value", aria: { label: "Copy some text" })
        end
      end
    end
  end
end
