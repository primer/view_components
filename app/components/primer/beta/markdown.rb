# frozen_string_literal: true

module Primer
  module Beta
    # Use `Markdown` to wrap markdown content.
    class Markdown < Primer::Component
      status :beta

      DEFAULT_TAG = :div
      TAG_OPTIONS = [DEFAULT_TAG, :article, :td].freeze

      # @param tag [Symbol] <%= one_of(Primer::Beta::Markdown::TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(tag: DEFAULT_TAG, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)

        @system_arguments[:classes] = class_names(
          "markdown-body",
          system_arguments[:classes]
        )
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
