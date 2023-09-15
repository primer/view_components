# frozen_string_literal: true

module Primer
  module Alpha
    RadioButtonGroup = Primer::FormComponents.from_input(Primer::Forms::Dsl::RadioButtonGroupInput)

    # A group of mutually exclusive radio buttons.
    #
    # @form_usage
    #   class ExampleForm < ApplicationForm
    #     form do |example_form|
    #       example_form.radio_button_group(attributes) do |group|
    #         group.radio_button(radio_button_attributes)
    #       end
    #     end
    #   end
    class RadioButtonGroup < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @param name [String] Value for the HTML name attribute.
      # @param label [String] Label text displayed above the input.
      # @param hidden [Boolean] When set to `true`, visually hides the group.
      # @param caption [String] A string describing the field and what sorts of input it expects. Displayed below the group.
      # @param invalid [Boolean] If set to `true`, the input will be marked as invalid. Implied if `validation_message` is truthy. This option is set to `true` automatically if the model object associated with the form reports that the input is invalid via Rails validations. It is provided for cases where the form does not have an associated model. If the input is invalid as determined by Rails validations, setting `invalid` to `false` will have no effect.
      # @param validation_message [String] A string displayed between the caption and the input indicating the input's contents are invalid. This option is, by default, set to the first Rails validation message for the input (assuming the form is associated with a model object). Use `validation_message` to override the default or to provide a validation message in case there is no associated model object.
      # @param label_arguments [Hash] Attributes that will be passed to Rails' `builder.label` method. These can be HTML attributes or any of the other label options Rails supports. They will appear as HTML attributes on the `<label>` tag.

      # @!method radio_button
      #
      # Adds a radio button to the group.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::RadioButton) %>.
      # @param block [Proc] The block accepted by <%= link_to_component(Primer::Alpha::RadioButton) %>.
    end
  end
end
