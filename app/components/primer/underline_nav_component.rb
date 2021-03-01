# frozen_string_literal: true

module Primer
  # Use the UnderlineNav component to style navigation with a minimal
  # underlined selected state, typically used for navigation placed at the top
  # of the page.
  class UnderlineNavComponent < Primer::Component
    ALIGN_DEFAULT = :left
    ALIGN_OPTIONS = [ALIGN_DEFAULT, :right].freeze

    with_content_areas :body, :actions

    # @example Default
    #   <%= render(Primer::UnderlineNavComponent.new) do |component| %>
    #     <% component.with(:body) do %>
    #       <%= render(Primer::LinkComponent.new(href: "#url")) { "Item 1" } %>
    #     <% end %>
    #     <% component.with(:actions) do %>
    #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example Align right
    #   <%= render(Primer::UnderlineNavComponent.new(align: :right)) do |component| %>
    #     <% component.with(:body) do %>
    #       <%= render(Primer::LinkComponent.new(href: "#url")) { "Item 1" } %>
    #     <% end %>
    #     <% component.with(:actions) do %>
    #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
    #     <% end %>
    #   <% end %>
    #
    # @param align [Symbol] <%= one_of(Primer::UnderlineNavComponent::ALIGN_OPTIONS) %> - Defaults to <%= Primer::UnderlineNavComponent::ALIGN_DEFAULT %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(align: ALIGN_DEFAULT, **system_arguments)
      @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)

      @system_arguments = system_arguments
      @system_arguments[:tag] = :nav
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "UnderlineNav",
        "UnderlineNav--right" => @align == :right
      )
    end
  end
end
