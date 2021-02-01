# frozen_string_literal: true

module Primer
  # The Heading component is a wrapper component that will create a heading element
  class HeadingComponent < Primer::Component
    # @example 70|Default
    #   <%= render(Primer::HeadingComponent.new) { "Heading Text" } %>
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
