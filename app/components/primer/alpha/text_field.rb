# frozen_string_literal: true

module Primer
  module Alpha
    TextField = Primer::FormComponents.from_input(Primer::Forms::Dsl::TextFieldInput)

    # A text field suitable for use outside a form. For a text field input suitable for use
    # within an HTML form, see the Primer forms documentation.
    class TextField < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @example Default
      #   <%= render(Primer::Alpha::TextField.new(name: :first_name, label: "First name")) %>
      #
      # @example With a clear button
      #   <%= render(
      #     Primer::Alpha::TextField.new(
      #       name: :first_name,
      #       label: "First name",
      #       show_clear_button: true
      #     )
      #   ) %>
      #
      # @example Full width
      #   <%= render(
      #     Primer::Alpha::TextField.new(
      #       name: :first_name,
      #       label: "First name",
      #       full_width: true
      #     )
      #   ) %>
      #
      # @example Disabled
      #   <%= render(
      #     Primer::Alpha::TextField.new(
      #       name: :first_name,
      #       label: "First name",
      #       disabled: true
      #     )
      #   ) %>
      #
      # @example Invalid
      #   <%= render(
      #     Primer::Alpha::TextField.new(
      #       name: :first_name,
      #       label: "First name",
      #       invalid: true
      #     )
      #   ) %>
      #
      # @example With a leading visual
      #   <%= render(
      #     Primer::Alpha::TextField.new(
      #       name: :first_name,
      #       label: "First name",
      #       leading_visual: {
      #         icon: :person
      #       }
      #     )
      #   ) %>
      #
      # @example With a caption
      #   <%= render(
      #     Primer::Alpha::TextField.new(
      #       name: :first_name,
      #       label: "First name",
      #       caption: "What your friends call you"
      #     )
      #   ) %>
      #
      # @example With a validation message
      #   <%= render(
      #     Primer::Alpha::TextField.new(
      #       name: :first_name,
      #       label: "First name",
      #       validation_message: "Hmm, that doesn't look right"
      #     )
      #   ) %>
      #
      # @macro form_input_attributes
      #
      # @param placeholder [String] Placeholder text.
      # @param inset [Boolean] If `true`, renders the input in a visually inset state.
      # @param monospace [Boolean] If `true`, uses a monospace font for the input field.
      # @param leading_visual [Hash] Renders a leading visual icon before the text field's cursor. The hash will be passed to Primer's <%= link_to_component(Primer::Beta::Octicon) component.
      # @param show_clear_button [Boolean] Whether or not to include a clear button inside the input that clears the input's contents when clicked.
      # @param clear_button_id [String] The HTML id attribute of the clear button.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    end
  end
end
