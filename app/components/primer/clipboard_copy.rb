# frozen_string_literal: true

module Primer
  # Use ClipboardCopy to copy element text content or input values to the clipboard.
  class ClipboardCopy < Primer::Component
    status :alpha

    # @example Default
    #   <%= render(Primer::ClipboardCopy.new(value: "Text to copy")) %>
    #
    # @example With text instead of icons
    #   <%= render(Primer::ClipboardCopy.new(value: "Text to copy")) do %>
    #     "Click to copy!"
    #   <% end %>
    #
    # @param value [String] Text to copy into the users clipboard when they click the component
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = "clipboard-copy"
    end
  end
end
