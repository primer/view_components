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
      # @param class [String] CSS classes to include in the input's HTML `class` attribute. Exists for compatibility with Rails form builders.
      # @param classes [Array] CSS classes to include in the input's HTML `class` attribute. Combined with the `:class` argument. The list may contain strings, hashes, or `nil` values, and is automatically cleaned up by Primer's [`class_name` helper](https://github.com/primer/view_components/blob/c9cb95c98fee3e2e27f4a10683f555e22285e7f1/app/lib/primer/class_name_helper.rb) (`nils`, falsy entries, and blank strings are ignored).
      # @param caption [String] A string describing the field and what sorts of input it expects. Displayed below the input.
      # @param label [String] Label text displayed above the input.
      # @param visually_hide_label [Boolean] When set to `true`, hides the label. Although the label will be hidden visually, it will still be visible to screen readers.
      # @param size [Symbol] The size of the field. <%= one_of(Primer::Forms::Dsl::Input::SIZE_OPTIONS) %>
      # @param show_clear_button [Boolean] Whether or not to include a clear button inside the input that clears the input's contents when clicked.
      # @param clear_button_id [String] The HTML id attribute of the clear button.
      # @param full_width [Boolean] When set to `true`, the field will take up all the horizontal space allowed by its container.
      # @param disabled [Boolean] When set to `true`, the input will not accept keyboard or mouse input.
      # @param hidden [Boolean] When set to `true`, visually hides the field.
      # @param invalid [Boolean] If set to `true`, the input will be rendered with a red border. Implied if `validation_message` is truthy. This option is set to `true` automatically if the model object associated with the form reports that the input is invalid via Rails validations. It is provided for cases where the form does not have an associated model. If the input is invalid as determined by Rails validations, setting `invalid` to `false` will have no effect.
      # @param placeholder [String] Placeholder text.
      # @param inset [Boolean] If `true`, renders the input in a visually inset state.
      # @param monospace [Boolean] If `true`, uses a monospace font for the input field.
      # @param leading_visual [Hash] Renders a leading visual icon before the text field's cursor. The hash will be passed to Primer's <%= link_to_component(Primer::Beta::Octicon) component.
      # @param validation_message [String] A string displayed between the caption and the input indicating the input's contents are invalid. This option is, by default, set to the first Rails validation message for the input (assuming the form is associated with a model object). Use `validation_message` to override the default or to provide a validation message in case there is no associated model object.
      # @param label_arguments [Hash] Attributes that will be passed to Rails' `builder.label` method. These can be HTML attributes or any of the other label options Rails supports. They will appear as HTML attributes on the `<label>` tag.
      # @param scope_name_to_model [Boolean] Default `true`. When set to `false`, prevents the model name from prefixing the field name. For example, if the field name is `my_field`, Rails will normally emit an HTML name attribute of `model[my_field]`. Setting `scope_name_to_model` to `false` will cause Rails to emit `my_field` instead.
      # @param scope_id_to_model [Boolean] Default `true`. When set to `false`, prevents the model name from prefixing the field ID. For example, if the field name is `my_field`, Rails will normally emit an HTML ID attribute of `model_my_field`. Setting `scope_id_to_model` to `false` will cause Rails to emit `my_field` instead.
      # @param required [Boolean] Default `false`. When set to `true`, causes an asterisk (*) to appear next to the field's label indicating it is a required field. Note that this option explicitly does _not_ add a `required` HTML attribute. Doing so would enable native browser validations, which are inaccessible and inconsistent with the Primer design system.
      # @param aria [Hash] Key/value pairs that represent Aria attributes and their values. Eg. `aria: { current: true }` becomes `aria-current="true"`.
      # @param data [Hash] Key/value pairs that represent data attributes and their values. Eg. `data: { foo: "bar" }` becomes `data-foo="bar"`.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      # @param block [Proc] Unused.
    end
  end
end
