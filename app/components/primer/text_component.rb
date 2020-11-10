# frozen_string_literal: true

module Primer
  # The Text component is a wrapper component that will apply typography styles to the text inside.
  class TextComponent < Primer::Component
    # @example 70|Default
    #   <%= render(Primer::TextComponent.new(tag: :p, font_weight: :bold)) { "Bold Text" } %>
    #   <%= render(Primer::TextComponent.new(tag: :p, color: :red_5)) { "Red Text" } %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :span
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
