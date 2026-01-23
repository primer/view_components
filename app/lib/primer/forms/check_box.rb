# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class CheckBox < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_label_classes("FormControl-label")
        @input.add_input_classes("FormControl-checkbox")

        # Generate custom ID that preserves brackets from the name
        unless @input.input_arguments[:id].present?
          generate_custom_id
          # Update the label's for attribute to match the new ID
          @input.label_arguments[:for] = @input.input_arguments[:id]
        end

        return unless @input.scheme == :array

        @input.input_arguments[:multiple] = true
        @input.label_arguments[:value] = checked_value
      end

      def nested_form_arguments
        return @nested_form_arguments if defined?(@nested_form_arguments)

        @nested_form_arguments = { hidden: @input.hidden?, **@input.nested_form_arguments }
        @nested_form_arguments[:class] = class_names(
          @nested_form_arguments[:class],
          @nested_form_arguments.delete(:classes),
          "ml-4"
        )

        @nested_form_arguments
      end

      private

      def generate_custom_id
        # Generate an ID from the name that preserves special characters like brackets
        # For array scheme: name + "_" + value (e.g., "permissions[3]_foo")
        # For boolean scheme: just the name (e.g., "long_o")
        base_name = @input.name.to_s
        
        # For array scheme, the name will have [] appended by Rails, so we need to remove it for ID generation
        # but only the trailing [] that Rails adds, not brackets that are part of the original name
        base_name = base_name.sub(/\[\]$/, "") if base_name.end_with?("[]")
        
        # For array scheme, append the value to make IDs unique
        # For boolean scheme, just use the base name
        if @input.scheme == :array && @input.value.present?
          @input.input_arguments[:id] = "#{base_name}_#{@input.value}"
        else
          @input.input_arguments[:id] = base_name
        end
      end

      def checked_value
        @input.value || "1"
      end

      def unchecked_value
        return if @input.scheme == :array

        @input.unchecked_value || "0"
      end
    end
  end
end
