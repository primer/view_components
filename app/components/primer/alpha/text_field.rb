# frozen_string_literal: true

module Primer
  module Alpha
    TextField = Primer::FormComponents.from_input(Primer::Forms::Dsl::TextFieldInput)

    # A text field suitable for use outside a form. For a text field input suitable for use
    # within an HTML form, see the `Primer::Forms` namespace.
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
      # @param name [String] Value for the HTML name attribute.
      # @param id [String] Value for the HTML id attribute.
      # @param class [String] A list of CSS classes to add to the input. Exists for compatibility with Rails form builders.
      # @param classes [String] A list of CSS classes to add to the input. Combined with the `:class` argument.
      # @param caption [String] Caption text to render below the input.
      # @param label [String] Label text displayed above the input.
      # @param visually_hide_label [Boolean] Whether or not to visually hide the label. If `true` the label will be hidden visually but still available to screen readers.
      # @param size [Symbol] The size of the field. <%= one_of(Primer::Forms::Dsl::Input::SIZE_OPTIONS) %>
      # @param show_clear_button [Boolean] Whether or not to include a clear button inside the input that clears the input's contents when clicked.
      # @param clear_button_id [String] The HTML id attribute of the clear button.
      # @param full_width [Boolean] Controls whether or not the input takes the full width of its container.
      # @param disabled [Boolean] Whether or not the input should accept keyboard and mouse input.
      # @param invalid [Boolean] If `true`, renders the input in a visually invalid state.
      # @param placeholder [String] Placeholder text.
      # @param inset [Boolean] If `true`, renders the input in a visually inset state.
      # @param monospace [Boolean] If `true`, uses a monospace font for the input field.
      # @param leading_visual [Hash] Renders a leading visual icon before the text field's cursor. The hash will be passed to Primer's [Octicon component](https://primer.style/view-components/components/octicon).
      # @param validation_message [String] A validation message to display beneath the input. Implicitly sets `invalid` to `true`.
      # @param label_arguments [Hash] System arugments passed to the Rails builder's `#label` method. These arguments will appear as HTML attributes on the `<label>` tag.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      # @param block [Proc] Unused.
    end
  end
end
