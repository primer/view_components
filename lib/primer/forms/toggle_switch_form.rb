# frozen_string_literal: true

module Primer
  module Forms
    class ToggleSwitchForm < Primer::Forms::Base
      # override to avoid accepting a builder argument
      def self.new(**options)
        allocate.tap { |obj| obj.send(:initialize, **options) }
      end

      def self.form(*)
        raise "ToggleSwitch forms only have a single field, and therefore do not support the `form' method."
      end

      def initialize(**system_arguments)
        @system_arguments = system_arguments
      end

      def render_in(view_context, &block)
        @builder = Primer::Forms::Builder.new(
          nil, nil, view_context, {}
        )

        super
      end

      private

      def define_inputs_on(obj)
        obj.toggle_switch(**@system_arguments)
      end
    end
  end
end
