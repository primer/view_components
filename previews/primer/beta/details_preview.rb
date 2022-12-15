# frozen_string_literal: true

module Primer
  module Beta
    # @label Details
    class DetailsPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param overlay [Symbol] select [none, default, dark]
      # @param reset [Boolean] toggle
      def playground(reset: false, overlay: :default)
        render Primer::Beta::Details.new(reset: reset, overlay: overlay) do |component|
          component.with_summary do
            "Summary"
          end
          component.with_body do
            "Body"
          end
        end
      end

      # @label Default options
      #
      # @param overlay [Symbol] select [none, default, dark]
      # @param reset [Boolean] toggle
      def default(reset: false, overlay: :default)
        render Primer::Beta::Details.new(reset: reset, overlay: overlay) do |component|
          component.with_summary do
            "Summary"
          end
          component.with_body do
            "Body"
          end
        end
      end

      # @label Custom button
      #
      # @param overlay [Symbol] select [none, default, dark]
      # @param reset [Boolean] toggle
      def custom_button(reset: false, overlay: :default)
        render Primer::Beta::Details.new(reset: reset, overlay: overlay) do |component|
          component.with_summary(size: :small, scheme: :primary) { "Click me" }
          component.with_body { "Body" }
        end
      end

      # @label Without button
      #
      # @param overlay [Symbol] select [none, default, dark]
      # @param reset [Boolean] toggle
      def without_button(reset: false, overlay: :default)
        render Primer::Beta::Details.new(reset: reset, overlay: overlay) do |component|
          component.with_summary(button: false) { "Click me" }
          component.with_body { "Body" }
        end
      end
    end
  end
end
