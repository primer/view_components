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
      # @param leading_spinner toggle
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
        full_width: true,
        disabled: false,
        invalid: false,
        validation_message: nil,
        placeholder: nil,
        inset: false,
        monospace: false,
        leading_visual_icon: nil,
        leading_spinner: false
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
          monospace: monospace,
          leading_spinner: leading_spinner
        }

        if leading_visual_icon
          system_arguments[:leading_visual] = {
            icon: leading_visual_icon,
            size: :small
          }
        end

        # You're required to specify a leading visual if a leading spinner is requested
        if leading_spinner && !leading_visual_icon
          system_arguments[:leading_visual] = {
            icon: :search,
            size: :small
          }
        end

        render(Primer::Alpha::TextField.new(**system_arguments))
      end

      # @label Default
      # @snapshot
      def default
        render(Primer::Alpha::TextField.new(name: "my-text-field", label: "My text field"))
      end

      # @!group Sizes
      #
      # @label Small
      # @snapshot
      def size_small
        render(Primer::Alpha::TextField.new(size: :small, visually_hide_label: true, name: "my-text-field", label: "My text field"))
      end

      # @label Medium
      # @snapshot
      def size_medium
        render(Primer::Alpha::TextField.new(size: :medium, visually_hide_label: true, name: "my-text-field", label: "My text field"))
      end

      # @label Large
      # @snapshot
      def size_large
        render(Primer::Alpha::TextField.new(size: :large, visually_hide_label: true, name: "my-text-field", label: "My text field"))
      end
      #
      # @!endgroup

      # @!group Options
      #
      # @label With caption
      # @snapshot
      def with_caption
        render(Primer::Alpha::TextField.new(caption: "With a caption", name: "my-text-field-1", label: "My text field"))
      end

      # @label Visually hidden label
      # @snapshot
      def visually_hide_label
        render(Primer::Alpha::TextField.new(visually_hide_label: true, name: "my-text-field-2", label: "My text field"))
      end

      # @label Show clear button
      # @snapshot
      def show_clear_button
        render(Primer::Alpha::TextField.new(show_clear_button: true, name: "my-text-field-3", label: "My text field"))
      end

      # @label Full width
      # @snapshot
      def full_width
        render(Primer::Alpha::TextField.new(full_width: true, name: "my-text-field-4", label: "My text field"))
      end

      # @label Not full width
      # @snapshot
      def not_full_width
        render(Primer::Alpha::TextField.new(full_width: false, name: "my-text-field-5", label: "My text field"))
      end

      # @label Disabled
      # @snapshot
      def disabled
        render(Primer::Alpha::TextField.new(disabled: true, name: "my-text-field-6", label: "My text field"))
      end

      # @label Invalid
      # @snapshot
      def invalid
        render(Primer::Alpha::TextField.new(invalid: true, name: "my-text-field-7", label: "My text field"))
      end

      # @label With placeholder
      # @snapshot
      def with_placeholder
        render(Primer::Alpha::TextField.new(placeholder: "with a placeholder", name: "my-text-field-8", label: "My text field"))
      end

      # @label Inset
      # @snapshot
      def inset
        render(Primer::Alpha::TextField.new(inset: true, name: "my-text-field-9", label: "My text field"))
      end

      # @label Monospace
      # @snapshot
      def monospace
        render(Primer::Alpha::TextField.new(monospace: true, name: "my-text-field-10", label: "My text field"))
      end

      # @label With trailing icon
      # @snapshot
      def with_trailing_icon
        render(Primer::Alpha::TextField.new(trailing_visual: { icon: { icon: :search } }, name: "my-text-field-11", label: "My text field"))
      end

      # @label With trailing text
      # @snapshot
      def with_trailing_text
        render(Primer::Alpha::TextField.new(trailing_visual: { text: { text: "minute" } }, name: "my-text-field-12", label: "My text field"))
      end

      # @label With trailing long text
      # @snapshot
      def with_trailing_long_text
        render(Primer::Alpha::TextField.new(trailing_visual: { text: { text: "Long trailing text" } }, name: "my-text-field-13", label: "My text field"))
      end

      # @label With trailing counter
      # @snapshot
      def with_trailing_counter
        render(Primer::Alpha::TextField.new(trailing_visual: { counter: { count: 5 } }, name: "my-text-field-14", label: "My text field"))
      end

      # @label With trailing label
      # @snapshot 
      def with_trailing_label
        render(Primer::Alpha::TextField.new(trailing_visual: { label: { text: "Hello" } }, name: "my-text-field-15", label: "My text field"))
      end

      # @label With leading visual
      # @snapshot
      def with_leading_visual
        render(Primer::Alpha::TextField.new(leading_visual: { icon: :search, "aria-label": "Search" }, name: "my-text-field-16", label: "My text field"))
      end

      # @label With validation message
      # @snapshot
      def with_validation_message
        render(Primer::Alpha::TextField.new(validation_message: "An error occurred!", name: "my-text-field-17", label: "My text field"))
      end
      #
      # @!endgroup

      # @!group Auto check 
      #
      # @label Auto check request ok
      def with_auto_check_ok
        render(Primer::Alpha::TextField.new(auto_check_src: UrlHelpers.primer_view_components.example_check_ok_path, name: "my-text-field-18", label: "My text field"))
      end

      # @label Auto check request accepted
      def with_auto_check_accepted
        render(Primer::Alpha::TextField.new(auto_check_src: UrlHelpers.primer_view_components.example_check_accepted_path, name: "my-text-field-19", label: "My text field"))
      end

      # @label Auto check request error
      def with_auto_check_error
        render(Primer::Alpha::TextField.new(auto_check_src: UrlHelpers.primer_view_components.example_check_error_path, name: "my-text-field-20", label: "My text field"))
      end
      #
      # @!endgroup

      # @label With data target attribute
      def with_data_target
        render(Primer::Alpha::TextField.new(name: "my-text-field", label: "My text field", data: { target: "custom-component.inputElement" }))
      end
      #
      # @!endgroup

      # @label Input group with leading button
      #
      # @snapshot
      def input_group_leading_button
        render_with_template
      end

      # @label Input group with trailing button
      #
      # @snapshot
      def input_group_trailing_button
        render_with_template
      end

      # @label Input group with ActionMenu
      #
      # @snapshot
      def input_group_leading_action_menu(route_format: :html)
        render_with_template(locals: { route_format: route_format })
      end
    end
  end
end
