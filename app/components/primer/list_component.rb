# frozen_string_literal: true

module Primer
  # Use List to create simple `<ul>` `<li>` HTML lists.
  class ListComponent < Primer::Component
    # Required list of items.
    #
    # @param unstyled [Boolean] Whether the item should be unstyled.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_many :items, lambda { |unstyled: false, **system_arguments|
      system_arguments[:tag] = :li
      system_arguments[:classes] = class_names(
        system_arguments[:classes],
        "list-style-none" => unstyled
      )
      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #   <%= render(Primer::ListComponent.new) do |c| %>
    #     <%= c.item { "Item 1" } %>
    #     <%= c.item { "Item 2" } %>
    #     <%= c.item { "Item 3" } %>
    #   <% end  %>
    #
    # @example Unstyled list
    #   <%= render(Primer::ListComponent.new(unstyled: true)) do |c| %>
    #     <%= c.item { "Item 1" } %>
    #     <%= c.item { "Item 2" } %>
    #     <%= c.item { "Item 3" } %>
    #   <% end  %>
    #
    # @example Unstyled item
    #   <%= render(Primer::ListComponent.new) do |c| %>
    #     <%= c.item { "Item 1" } %>
    #     <%= c.item(unstyled: true) { "Item 2" } %>
    #     <%= c.item { "Item 3" } %>
    #   <% end  %>
    #
    # @param unstyled [Boolean] Whether the list should be unstyled.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(unstyled: false, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:classes] = class_names(
        system_arguments[:classes],
        "list-style-none" => unstyled
      )
      @system_arguments[:tag] = :ul
    end

    def render?
      items.any?
    end
  end
end
