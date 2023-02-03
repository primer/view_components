# frozen_string_literal: true

module Primer
  module Forms
    # Toggle switches are designed to submit an on/off value to the server immediately
    # upon click. For that reason they are not designed to be used in "regular" forms
    # that have other fields, etc. Instead they should be used independently via this
    # class.
    #
    # ToggleSwitchForm can be used directly or via inheritance.
    #
    # Via inheritance:
    #
    # # app/forms/my_toggle_form.rb
    # class MyToggleForm < Primer::Forms::ToggleSwitchForm
    #   def initialize(**system_arguments)
    #     super(name: :foo, label: "Foo", src: "/foo", **system_arguments)
    #   end
    # end
    #
    # # app/views/some_view.html.erb
    # <%= render(MyToggleForm.new) %>
    #
    # Directly:
    #
    # # app/views/some_view.html.erb
    # <%= render(
    #   Primer::Forms::ToggleSwitchForm.new(
    #     name: :foo, label: "Foo", src: "/foo"
    #   )
    # ) %>
    #
    class ToggleSwitchForm < Primer::Forms::Base
      # Define the form on subclasses so render(Subclass.new) works as expected.
      # (this is called directly on this class, but also on classes
      # that inherit from this class)
      def self.define_form_on(klass)
        klass.form do |toggle_switch_form|
          input = Dsl::ToggleSwitchInput.new(
            builder: toggle_switch_form.builder, form: self, **@system_arguments
          )

          toggle_switch_form.send(:add_input, input)
        end
      end

      def self.inherited(base)
        super
        define_form_on(base)
      end

      # Define the form on self so render(ToggleSwitchForm.new) works as expected.
      define_form_on(self)

      # Override to avoid accepting a builder argument. We create our own builder
      # on render. See the implementation of render_in below.
      def self.new(**options)
        allocate.tap { |obj| obj.send(:initialize, **options) }
      end

      def initialize(**system_arguments)
        @system_arguments = system_arguments
      end

      # Unlike other instances of Base, ToggleSwitchForm defines its own form and
      # is not given a Rails form builder on instantiation. We do this mostly for
      # ergonomic reasons; it's much less verbose than if you were required to
      # call form_with/form_for, etc. That said, the rest of the forms framework
      # assumes the presence of a builder so we create our own here. A builder
      # cannot be constructed without a corresponding view context, which is why
      # we have to override render_in and can't create it in the initializer.
      def render_in(view_context, &block)
        @builder = Primer::Forms::Builder.new(
          nil, nil, view_context, {}
        )

        super
      end
    end
  end
end
