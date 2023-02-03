# frozen_string_literal: true

module Primer
  module Alpha
    # @label TextField
    class TextFieldPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param name text
      # @param id text
      # @param label text
      # @param caption text
      # @param required toggle
      # @param visually_hide_label toggle
      # @param size [Symbol] select [small, medium, large]
      # @param show_clear_button toggle
      # @param clear_button_id text
      # @param full_width toggle
      # @param disabled toggle
      # @param invalid toggle
      # @param validation_message text
      # @param placeholder text
      # @param inset toggle
      # @param monospace toggle
      # @param leading_visual_icon octicon
      def playground(
        name: "my-text-field",
        id: "my-text-field",
        label: "My text field",
        caption: "My text field",
        required: false,
        visually_hide_label: false,
        size: Primer::Forms::Dsl::Input::DEFAULT_SIZE.to_s,
        show_clear_button: false,
        clear_button_id: "my-text-field-clear-button",
        full_width: false,
        disabled: false,
        invalid: false,
        validation_message: nil,
        placeholder: nil,
        inset: false,
        monospace: false,
        leading_visual_icon: nil
      )
        system_arguments = {
          name: name,
          id: id,
          label: label,
          caption: caption,
          required: required,
          visually_hide_label: visually_hide_label,
          size: size,
          show_clear_button: show_clear_button,
          clear_button_id: clear_button_id,
          full_width: full_width,
          disabled: disabled,
          invalid: invalid,
          validation_message: validation_message,
          placeholder: placeholder,
          inset: inset,
          monospace: monospace
        }

        if leading_visual_icon
          system_arguments[:leading_visual] = {
            icon: leading_visual_icon,
            size: :small
          }
        end

        render(Primer::Alpha::TextField.new(**system_arguments))
      end

      # @label Default
      def default
        render(Primer::Alpha::TextField.new(name: "my-text-field", label: "My text field"))
      end

      # @!group Sizes
      #
      # @label Small
      def size_small
        render(Primer::Alpha::TextField.new(size: :small, visually_hide_label: true, name: "my-text-field", label: "My text field"))
      end

      # @label Medium
      def size_medium
        render(Primer::Alpha::TextField.new(size: :medium, visually_hide_label: true, name: "my-text-field", label: "My text field"))
      end

      # @label Large
      def size_large
        render(Primer::Alpha::TextField.new(size: :large, visually_hide_label: true, name: "my-text-field", label: "My text field"))
      end
      #
      # @!endgroup

      # @!group Options
      #
      # @label With caption
      def with_caption
        render(Primer::Alpha::TextField.new(caption: "With a caption", name: "my-text-field", label: "My text field"))
      end

      # @label Visually hidden label
      def visually_hide_label
        render(Primer::Alpha::TextField.new(visually_hide_label: true, name: "my-text-field", label: "My text field"))
      end

      # @label Show clear button
      def show_clear_button
        render(Primer::Alpha::TextField.new(show_clear_button: true, name: "my-text-field", label: "My text field"))
      end

      # @label Full width
      def full_width
        render(Primer::Alpha::TextField.new(full_width: true, name: "my-text-field", label: "My text field"))
      end

      # @label Disabled
      def disabled
        render(Primer::Alpha::TextField.new(disabled: true, name: "my-text-field", label: "My text field"))
      end

      # @label Invalid
      def invalid
        render(Primer::Alpha::TextField.new(invalid: true, name: "my-text-field", label: "My text field"))
      end

      # @label With placeholder
      def with_placeholder
        render(Primer::Alpha::TextField.new(placeholder: "with a placeholder", name: "my-text-field", label: "My text field"))
      end

      # @label Inset
      def inset
        render(Primer::Alpha::TextField.new(inset: true, name: "my-text-field", label: "My text field"))
      end

      # @label Monospace
      def monospace
        render(Primer::Alpha::TextField.new(monospace: true, name: "my-text-field", label: "My text field"))
      end

      # @label With leading visual
      def with_leading_visual
        render(Primer::Alpha::TextField.new(leading_visual: { icon: :search }, name: "my-text-field", label: "My text field"))
      end

      # @label With validation message
      def with_validation_message
        render(Primer::Alpha::TextField.new(validation_message: "An error occurred!", name: "my-text-field", label: "My text field"))
      end
      #
      # @!endgroup

      # @!group Auto check
      #
      # @label Auto check request ok
      def with_auto_check_ok
        render(Primer::Alpha::TextField.new(auto_check_src: UrlHelpers.example_check_ok_path, name: "my-text-field", label: "My text field"))
      end

      # @label Auto check request error
      def with_auto_check_error
        render(Primer::Alpha::TextField.new(auto_check_src: UrlHelpers.example_check_error_path, name: "my-text-field", label: "My text field"))
      end
      #
      # @!endgroup
    end
  end
end
