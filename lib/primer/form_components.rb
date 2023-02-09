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

        def initialize(**system_arguments)
          @system_arguments = system_arguments
        end

        def render_in(view_context, &block)
          builder = Primer::Forms::Builder.new(
            nil, nil, view_context, {}
          )

          # `block` is the block passed to `#render`. We pass it to the
          # input's constructor here to mimic the way constructors often
          # yield in the forms framework. Only allowing the block to be
          # passed to `#initialize` is awkward because `#render` is often
          # called without parens, making it non-obvious which method the
          # block is passed to. Moreover, users of view components expect
          # `#render` to accept a block and for that block to yield the
          # component, which allows setting slots, etc. They do not expect
          # that block to be accepted by the component's initializer
          # instead.
          #
          # One caveat here is that not all form input classes yield
          # themselves to the block. In such a case, the block will
          # never be called, which is potentially confusing. We could
          # detect whether or not the block is called and yield the input
          # if it is not, but that comes with its own set of problems and
          # could also lead to confusion (for example, if the block is
          # conditionally called with one set of arguments from the input
          # and then a different set of arguments here). Since we can't
          # know which arguments the input will yield, it's safer to simply
          # pass the block as-is.
          input = self.class.input_klass.new(
            builder: builder,
            form: nil,
            **@system_arguments,
            &block
          )

          input.to_component.render_in(view_context) { content }
        end
      end
    end
  end
end
