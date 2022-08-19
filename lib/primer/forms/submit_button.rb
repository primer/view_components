# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class SubmitButton < BaseComponent
      # :nodoc:
      module SubmitAttributeGenerator
        extend ActionView::Helpers::FormTagHelper

        class << self
          alias submit_tag_attributes submit_tag

          private

          # FormTagHelper#submit_tag ultimately calls the #tag method. We return the options hash here instead
          # of returning a string so it can be merged into the hash of options we pass to the Primer::ButtonComponent.
          def tag(_name, options)
            options
          end
        end
      end

      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes("FormField-input flex-self-start")
        @input.merge_input_arguments!(
          SubmitAttributeGenerator.submit_tag_attributes(input.label, name: input.name).deep_symbolize_keys
        )

        # rails uses a string for this, but PVC wants a symbol
        @input.merge_input_arguments!(type: :submit)

        # Never disable submit buttons. This overrides the global
        # ActionView::Base.automatically_disable_submit_tag setting.
        # Disabling the submit button is not accessible.
        @input.remove_input_data(:disable_with)
      end

      def input_arguments
        @input_arguments ||= @input.input_arguments.deep_dup.tap do |args|
          # rails uses :class but PVC wants :classes
          args[:classes] = args.delete(:class)
        end
      end
    end
  end
end
