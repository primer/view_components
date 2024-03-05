# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class AutoComplete < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.merge_input_arguments!(text_field_attributes.deep_symbolize_keys)
      end

      def self.auto_complete_argument_names
        @auto_complete_argument_names ||=
          Primer::Beta::AutoComplete.instance_method(:initialize)
            .parameters
            .filter_map { |(type, param_name)| next param_name if type == :keyreq || type == :key }
      end

      private

      def all_input_arguments
        @all_input_arguments ||= @input.input_arguments.deep_dup.tap do |args|
          # rails uses :class but PVC wants :classes
          args[:classes] = class_names(
            args[:classes],
            args.delete(:class)
          )
        end
      end

      def auto_complete_arguments
        all_args = all_input_arguments
        all_args
          .slice(*self.class.auto_complete_argument_names)
          .merge(
            input_name: all_args[:name],
            input_id: all_args[:id],
            label_text: @input.label,
            list_id: "#{all_args[:id]}-list"
          )
      end

      def input_arguments
        all_input_arguments.except(*self.class.auto_complete_argument_names)
      end

      def text_field_attributes
        builder.text_field_attributes(@input.name).except("size", "value")
      end
    end
  end
end
