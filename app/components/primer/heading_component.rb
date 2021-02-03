# frozen_string_literal: true

module Primer
  # Use the Heading component to wrap a component that will create a heading element
  class HeadingComponent < Primer::Component
    # @example 70|Default
    #   <%= render(Primer::HeadingComponent.new) { "H1 Text" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h2)) { "H2 Text" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h3)) { "H3 Text" } %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :h1
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
