# frozen_string_literal: true

module Primer
  # :nocov:
  # :nodoc:
  class FormComponents
    def self.from_input(input_klass)
      Class.new(Primer::Component) do
        @input_klass = input_klass

        class << self
          attr_reader :input_klass
        end

        def initialize(**system_arguments, &block)
          @system_arguments = system_arguments
          @block = block
        end

        def call
          builder = Primer::Forms::Builder.new(
            nil, nil, __vc_original_view_context, {}
          )

          input = self.class.input_klass.new(
            builder: builder,
            form: nil,
            **@system_arguments,
            &@block
          )

          input.to_component.render_in(__vc_original_view_context) { content }
        end
      end
    end
  end
end
