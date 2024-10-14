# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class FormObject
        include InputMethods

        attr_reader :builder, :form

        def initialize(builder:, form:)
          @builder = builder
          @form = form

          yield(self) if block_given?
        end

        def group(**options, &block)
          add_input InputGroup.new(builder: @builder, form: @form, **options, &block)
        end
      end
    end
  end
end
