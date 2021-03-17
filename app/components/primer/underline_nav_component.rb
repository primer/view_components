# frozen_string_literal: true

module Primer
  # Use the UnderlineNav component to style navigation with a minimal
  # underlined selected state, typically used for navigation placed at the top
  # of the page.
  class UnderlineNavComponent < Primer::Component
    include ViewComponent::SlotableV2

    ALIGN_DEFAULT = :left
    ALIGN_OPTIONS = [ALIGN_DEFAULT, :right].freeze

    # Use the tabs to list navigation items.
    #
    # @param selected [Boolean] Whether the tab is selected.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_many :tabs, lambda { |selected: false, **system_arguments|
      system_arguments[:classes] = class_names(
        "UnderlineNav-item",
        system_arguments[:classes]
      )
      Primer::Navigation::TabComponent.new(selected: selected, with_panel: @with_panel, **system_arguments)
    }

    # Use actions for a call to action.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :actions, lambda { |**system_arguments|
      system_arguments[:tag] ||= :div
      system_arguments[:classes] = class_names("UnderlineNav-actions", system_arguments[:classes])

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #   <%= render(Primer::UnderlineNavComponent.new) do |component| %>
    #     <% component.tab(href: "#", selected: true) do %>
    #       Item 1
    #     <% end %>
    #     <% component.tab(href: "#") do %>
    #       Item 2
    #     <% end %>
    #     <% component.actions do %>
    #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example Align right
    #   <%= render(Primer::UnderlineNavComponent.new(align: :right)) do |component| %>
    #     <% component.tab(href: "#", selected: true) do %>
    #       Item 1
    #     <% end %>
    #     <% component.tab(href: "#") do %>
    #       Item 2
    #     <% end %>
    #     <% component.actions do %>
    #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example With panels
    #   <%= render(Primer::UnderlineNavComponent.new(with_panel: true)) do |component| %>
    #     <% component.tab(selected: true) do |t| %>
    #       Item 1
    #       <% t.panel do %>
    #         Panel 1
    #       <% end %>
    #     <% end %>
    #     <% component.tab do |t| %>
    #       Item 2
    #       <% t.panel do %>
    #         Panel 2
    #       <% end %>
    #     <% end %>
    #     <% component.actions do %>
    #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
    #     <% end %>
    #   <% end %>
    #
    # @param with_panel [Boolean] Whether the TabNav should navigate through pages or panels.
    # @param align [Symbol] <%= one_of(Primer::UnderlineNavComponent::ALIGN_OPTIONS) %> - Defaults to <%= Primer::UnderlineNavComponent::ALIGN_DEFAULT %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(with_panel: false, align: ALIGN_DEFAULT, body_classes: "", **system_arguments)
      @with_panel = with_panel
      @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)

      @system_arguments = system_arguments
      @system_arguments[:tag] = :nav
      @system_arguments[:role] = :tablist
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "UnderlineNav",
        "UnderlineNav--right" => @align == :right
      )

      @body_arguments = {
        tag: :div,
        classes: class_names(
          "UnderlineNav-body",
          body_classes
        )
      }
    end

    def wrapper
      return yield unless @with_panel

      render Primer::TabContainerComponent.new do
        yield
      end
    end

    def body
      Primer::BaseComponent.new(**@body_arguments)
    end

    def render?
      tabs.any?
    end
  end
end
