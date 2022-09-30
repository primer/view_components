# frozen_string_literal: true

module Primer
  module Beta
    # @label Details
    class DetailsPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param overlay [Symbol] select [none, default, dark]
      # @param reset [Boolean] toggle
      def default(reset: false, overlay: :default)
        render Primer::Beta::Details.new(reset: reset, overlay: overlay) do |c|
          c.with_summary do
            "Summary"
          end
          c.with_body do
            "Body"
          end
        end
      end

      # @label Custom button
      #
      # @param overlay [Symbol] select [none, default, dark]
      # @param reset [Boolean] toggle
      def custom_button(reset: false, overlay: :default)
        render Primer::Beta::Details.new(reset: reset, overlay: overlay) do |c|
          c.summary(size: :small, scheme: :primary) { "Click me" }
          c.body { "Body" }
        end
      end

      # @label Without button
      #
      # @param overlay [Symbol] select [none, default, dark]
      # @param reset [Boolean] toggle
      def without_button(reset: false, overlay: :default)
        render Primer::Beta::Details.new(reset: reset, overlay: overlay) do |c|
          c.summary(button: false) { "Click me" }
          c.body { "Body" }
        end
      end
    end
  end
end
