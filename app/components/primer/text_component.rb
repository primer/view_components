# frozen_string_literal: true

module Primer
  # The Text component is a wrapper component that will apply typography styles to the text inside.
  class TextComponent < Primer::Component
    # @example 70|Default
    #   <%= render(Primer::TextComponent.new(tag: :p, font_weight: :bold)) { "Bold Text" } %>
    #   <%= render(Primer::TextComponent.new(tag: :p, color: :red_5)) { "Red Text" } %>
    #
    # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] ||= :span
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
