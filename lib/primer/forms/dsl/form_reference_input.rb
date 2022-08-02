# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class FormReferenceInput < Input
        attr_reader :ref_block, :fields_for_args, :fields_for_kwargs

        def initialize(*fields_for_args, builder:, form:, **fields_for_kwargs, &block)
          @fields_for_args = fields_for_args
          @fields_for_kwargs = fields_for_kwargs
          @ref_block = block

          super(builder: builder, form: form, **fields_for_kwargs)
        end

        def to_component
          FormReference.new(input: self)
        end

        def name
          nil
        end

        def label
          nil
        end

        def type
          :form
        end
      end
    end
  end
end
