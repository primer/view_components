# frozen_string_literal: true

module Primer
  # Use ClipboardCopy to copy element text content or input values to the clipboard.
  class ClipboardCopy < Primer::Component
    status :alpha

    # @example Default
    #   <%= render(Primer::ClipboardCopy.new(value: "Text to copy", label: "Copy text to the system clipboard")) %>
    #
    # @example With text instead of icons
    #   <%= render(Primer::ClipboardCopy.new(value: "Text to copy", label: "Copy text to the system clipboard")) do %>
    #     "Click to copy!"
    #   <% end %>
    #
    # @param label [String] String that will be read to screenreaders when the component is focused
    # @param value [String] Text to copy into the users clipboard when they click the component
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(label:, value:, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = "clipboard-copy"
      @system_arguments[:value] = value
      @system_arguments[:"aria-label"] = label
    end
  end
end
