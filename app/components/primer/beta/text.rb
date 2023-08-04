# frozen_string_literal: true

module Primer
  module Beta
    # `Text` is a wrapper component that will apply typography styles to the text inside.
    class Text < Primer::Component
      status :beta

      DEFAULT_TAG = :span

      # @param tag [Symbol]
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(tag: DEFAULT_TAG, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = tag
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
