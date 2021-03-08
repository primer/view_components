# frozen_string_literal: true

module Primer
  # A basic wrapper component for most layout related needs.
  class BoxComponent < Primer::Component
    status :stable

    # @example Default
    #   <%= render(Primer::BoxComponent.new) { "Your content here" } %>
    #
    # @example Color and padding
    #   <%= render(Primer::BoxComponent.new(bg: :gray, p: 3)) { "Hello world" } %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
