# frozen_string_literal: true

module Primer
  # :nodoc:
  class FormComponents
    def self.from_input(input_klass)
      Class.new(ViewComponent::Base) do
        @input_klass = input_klass

        class << self
          attr_reader :input_klass
        end

        def initialize(**kwargs, &block)
          @kwargs = kwargs
          @block = block
        end

        def call
          builder = ActionView::Helpers::FormBuilder.new(nil, nil, self, {})

          input = self.class.input_klass.new(
            builder: builder,
            form: nil,
            **@kwargs,
            &@block
          )

          input.render_in(self) { content }
        end
      end
    end
  end
end
