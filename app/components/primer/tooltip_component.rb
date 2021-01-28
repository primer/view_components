# frozen_string_literal: true

module Primer
  # The Tooltip component is a wrapper component that will apply a tooltip
  class TooltipComponent < Primer::Component
    # @example 50|Default
    #   <%= render(Primer::TooltipComponent.new(label: "Even bolder")) { "Bold Text" } %>
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
