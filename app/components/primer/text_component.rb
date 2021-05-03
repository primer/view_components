# frozen_string_literal: true

module Primer
  # `Text` is a wrapper component that will apply typography styles to the text inside.
  class TextComponent < Primer::Component
    status :beta

    DEFAULT_TAG = :span

    # @example Default
    #   <%= render(Primer::TextComponent.new(tag: :p, font_weight: :bold)) { "Bold Text" } %>
    #   <%= render(Primer::TextComponent.new(tag: :p, color: :text_danger)) { "Danger Text" } %>
    #
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
