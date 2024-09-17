# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class FormReferenceInput < Input
        attr_reader :ref_block, :fields_for_args, :fields_for_kwargs, :nested
        alias nested? nested

        # Pass `nested: false` to prevent the referenced form fields from being treated as nested
        # under the parent form's model. For example, consider these models:

        # class User < ActiveRecord::Base
        #   has_many :addresses
        # end

        # class Address < ActiveRecord::Base
        #   belongs_to :user
        # end

        # A sign-up form might include fields from `User` as well as `Address`. Since addresses are
        # associated with users, it's perfectly natural to accept the address fields as nested
        # attributes. Rails will name each field accordingly. For example, the `street` field on
        # `Address` will be named `user[address][street]`.

        # For situations like this where an association exists between two models, the nested
        # attributes approach works great. However sometimes all you want is to compose two forms
        # together that aren't connected by an association. In such cases the fields will still
        # include the name of the parent model, eg. `user[address][street]` instead of what we want,
        # `address[street]`. To render the form independent of the parent, pass `nested: false`.
        def initialize(*fields_for_args, builder:, form:, nested: true, **fields_for_kwargs, &block)
          @fields_for_args = fields_for_args
          @fields_for_kwargs = fields_for_kwargs
          @nested = nested
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
