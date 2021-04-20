# frozen_string_literal: true

module Primer
  # Use ClipboardCopy to copy element text content or input values to the clipboard.
  class ClipboardCopy < Primer::Component
    status :alpha

    # Optional target element that holds the data the user will copy.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :target, lambda { |**system_arguments|
      system_arguments[:tag] ||= :div
      system_arguments[:id] = @id

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #   <%= render(Primer::ClipboardCopy.new(value: "Text to copy")) do %>
    #     "Click to copy!"
    #   <% end %>
    #
    # @example With a target
    #   <%= render(Primer::ClipboardCopy.new(id: "foo")) do |component|
    #     <%= component.target do %>
    #       Text to copy
    #     <% end %>
    #
    #     Click to copy!
    #   <% end %>
    #
    # @example With a form target
    #   <%= render(Primer::ClipboardCopy.new(id: "foo")) do |component|
    #     <%= component.target(tag: :input, value: "Text to copy") %>
    #
    #     Click to copy!
    #   <% end %>
    #
    # @example With a link target
    #   <%= render(Primer::ClipboardCopy.new(id: "foo")) do |component|
    #     <%= component.target(tag: :a, href: "/path/to/copy") %>
    #
    #     Click to copy!
    #   <% end %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @id = system_arguments[:id]
      system_arguments[:id] = nil
      @text = system_arguments[:text]

      @system_arguments = system_arguments
      @system_arguments[:tag] = "clipboard-copy"
      @system_arguments[:for] = @id unless system_arguments[:value]
    end
  end
end
