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
      # @param hidden [Boolean] When set to `true`, visually hides the group.
      # @param caption [String] A string describing the field and what sorts of input it expects. Displayed below the group.
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
