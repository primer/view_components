# frozen_string_literal: true

module Primer
  module Alpha
    # Wraps an input (or arbitrary content) with a label above and a caption and validation message beneath.
    # NOTE: This `FormControl` component is designed for wrapping inputs that aren't supported by the Primer
    # forms framework.
    class FormControl < Primer::Component
      # Describes the field and what sorts of input it expects. Displayed below the input.
      # Note that this slot takes precedence over the `caption:` argument in the constructor.
      renders_one :caption

      # @param label [String] Label text displayed above the input.
      # @param caption [String] Describes the field and what sort of input it expects. Displayed below the input. Note that the `caption` slot is also available and takes precedence over this argument when provided.
      # @param validation_message [String] A string displayed in red between the caption and the input indicating the input's contents are invalid.
      # @param required [Boolean] Default `false`. When set to `true`, causes an asterisk (*) to appear next to the field's label indicating it is a required field. Note that this option explicitly does _not_ add a `required` HTML attribute. Doing so would enable native browser validations, which are inaccessible and inconsistent with the Primer design system.
      # @param visually_hide_label [Boolean] When set to `true`, hides the label. Although the label will be hidden visually, it will still be visible to screen readers.
      # @param full_width [Boolean] When set to `true`, the form control will take up all the horizontal space allowed by its container.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(label:, caption: nil, validation_message: nil, required: false, visually_hide_label: false, full_width: false, **system_arguments)
        @label = label
        @init_caption = caption
        @validation_message = validation_message
        @required = required
        @visually_hide_label = visually_hide_label
        @full_width = full_width
        @system_arguments = system_arguments

        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "FormControl",
          "FormControl--fullWidth" => full_width?
        )

        @label_arguments = {
          classes: class_names(
            "FormControl-label",
            visually_hide_label? ? "sr-only" : nil
          )
        }

        base_id = self.class.generate_id
        @validation_id = "validation-#{base_id}"
        @caption_id = "caption-#{base_id}"

        @validation_arguments = {
          classes: "FormControl-inlineValidation",
          id: @validation_id
        }
      end

      # @!parse
      #   # The input content. Yields a set of <%= link_to_system_arguments_docs %> that should be added to the input.
      #   #
      #   renders_one(:input)

      def with_input(&block)
        @input_block = block
      end

      def required?
        @required
      end

      def visually_hide_label?
        @visually_hide_label
      end

      def full_width?
        @full_width
      end

      private

      def before_render
        # make sure to evaluate the component's content block so slots are defined
        content

        @input_arguments = {
          aria: {}
        }

        ids = [].tap do |memo|
          memo << @validation_id if @validation_message
          memo << @caption_id if @init_caption || caption?
        end

        return if ids.empty?

        @input_arguments[:aria][:describedby] = ids.join(" ")
      end
    end
  end
end
