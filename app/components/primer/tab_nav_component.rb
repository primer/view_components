# frozen_string_literal: true

module Primer
  # Use TabNav to style navigation with a tab-based selected state, typically used for navigation placed at the top of the page.
  class TabNavComponent < Primer::Component
    include Primer::TabbedComponentHelper

    # Tabs to be rendered.
    #
    # @param selected [Boolean] Whether the tab is selected.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_many :tabs, lambda { |selected: false, **system_arguments|
      system_arguments[:classes] = class_names(
        "tabnav-tab",
        system_arguments[:classes]
      )
      Primer::Navigation::TabComponent.new(selected: selected, with_panel: @with_panel, **system_arguments)
    }

    # @example Default
    #   <%= render(Primer::TabNavComponent.new) do |c| %>
    #     <% c.tab(selected: true, href: "#") { "Tab 1" }%>
    #     <% c.tab(href: "#") { "Tab 2" } %>
    #     <% c.tab(href: "#") { "Tab 3" } %>
    #   <% end %>
    #
    # @example With panels
    #   <%= render(Primer::TabNavComponent.new(with_panel: true)) do |c| %>
    #     <% c.tab(selected: true) do |t| %>
    #       <% t.title { "Tab 1" } %>
    #       <% t.panel do %>
    #         Panel 1
    #       <% end %>
    #     <% end %>
    #     <% c.tab do |t| %>
    #       <% t.title { "Tab 2" } %>
    #       <% t.panel do %>
    #         Panel 2
    #       <% end %>
    #     <% end %>
    #     <% c.tab do |t| %>
    #       <% t.title { "Tab 3" } %>
    #       <% t.panel do %>
    #         Panel 3
    #       <% end %>
    #     <% end %>
    #   <% end %>
    #
    # @param aria_label [String] Used to set the `aria-label` on the top level `<nav>` element.
    # @param with_panel [Boolean] Whether the TabNav should navigate through pages or panels.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(aria_label: nil, with_panel: false, **system_arguments)
      @aria_label = aria_label
      @with_panel = with_panel
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :div

      @system_arguments[:classes] = class_names(
        "tabnav",
        system_arguments[:classes]
      )
    end
  end
end
