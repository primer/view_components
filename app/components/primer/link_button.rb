# frozen_string_literal: true

module Primer
  # Use LinkButton to create a button that looks like a link rather than using an `<a>` to trigger JS.
  class LinkButton < Primer::Component
    # @example Default
    #   <%= render(Primer::LinkButton.new) %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :button
      @system_arguments[:type] = :button
      @system_arguments[:block] = false
      @system_arguments[:classes] = class_names(
        "btn-link",
        system_arguments[:classes]
      )
    end

    def call
      render(Primer::BaseButton.new(**@system_arguments)) { content }
    end
  end
end
