# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class InputGroup
        include InputMethods

        attr_reader :builder, :form, :system_arguments

        def initialize(builder:, form:, **system_arguments)
          @builder = builder
          @form = form
          @system_arguments = system_arguments

          yield(self) if block_given?
        end

        def to_component
          Group.new(inputs: inputs, builder: builder, form: form, **@system_arguments)
        end

        def type
          :group
        end

        def input?
          true
        end

        # Avoid using Rails delegation here for performance reasons
        # rubocop:disable Rails/Delegate
        def render_in(view_context)
          to_component.render_in(view_context)
        end
        # rubocop:enable Rails/Delegate
      end
    end
  end
end
