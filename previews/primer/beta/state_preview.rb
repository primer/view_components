# frozen_string_literal: true

module Primer
  module Beta
    # @label State
    class StatePreview < ViewComponent::Preview
      # @label Playground
      #
      # @param title [String]
      # @param tag [Symbol] select [span, div]
      # @param size [Symbol] select [default, small]
      # @param scheme [Symbol] select [default, open, closed, merged]
      def playground(title: "State", scheme: :default, size: :default, tag: :span)
        render(Primer::Beta::State.new(title: title, scheme: scheme, size: size, tag: tag)) { "State" }
      end

      # @label Default
      #
      # @param title [String]
      # @param tag [Symbol] select [span, div]
      # @param size [Symbol] select [default, small]
      # @param scheme [Symbol] select [default, open, closed, merged]
      def default(title: "State", scheme: :default, size: :default, tag: :span)
        render(Primer::Beta::State.new(title: title, scheme: scheme, size: size, tag: tag)) { "State" }
      end

      # @!group States
      #
      # @label Default
      def states_default
        render(Primer::Beta::State.new(title: "Default")) { "Default state" }
      end

      # @label Open
      def states_open
        render(Primer::Beta::State.new(title: "Open", scheme: :open)) { "Open state" }
      end

      # @label Closed
      def states_closed
        render(Primer::Beta::State.new(title: "Closed", scheme: :closed)) { "Closed state" }
      end

      # @label Merged
      def states_merged
        render(Primer::Beta::State.new(title: "Merged", scheme: :merged)) { "Merged state" }
      end
      #
      # @!endgroup

      # @!group Sizes
      #
      # @label Default
      def sizes_default
        render(Primer::Beta::State.new(title: "Default")) { "Default size" }
      end

      # @label Small
      def sizes_small
        render(Primer::Beta::State.new(title: "Default", size: :small)) { "Small size" }
      end
      #
      # @!endgroup
    end
  end
end
