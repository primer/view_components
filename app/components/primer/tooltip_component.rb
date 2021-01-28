# frozen_string_literal: true

module Primer
  # The Tooltip component is a wrapper component that will apply a tooltip
  class TooltipComponent < Primer::Component
    # @example 50|Default
    #   <%= render(Primer::TooltipComponent.new(label: "Even bolder")) { "Bold Text" } %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(label:, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :span
      @system_arguments[:aria] = { label: label }

      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "tooltipped",
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
