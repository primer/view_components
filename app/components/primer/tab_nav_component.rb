# frozen_string_literal: true

module Primer
  # Use `TabNav` to style navigation with a tab-based selected state, typically used for navigation placed at the top of the page.
  class TabNavComponent < Primer::Component
    include Primer::TabbedComponentHelper

    status :beta

    DEFAULT_EXTRA_ALIGN = :left
    EXTRA_ALIGN_OPTIONS = [DEFAULT_EXTRA_ALIGN, :right].freeze

    # Tabs to be rendered. When `with_panel` is set on the parent, a button is rendered for panel navigation. Otherwise,
    # an anchor tag is rendered for page navigation. For more information, refer to <%= link_to_component(Primer::Navigation::TabComponent) %>.
    #
    # @param selected [Boolean] Whether the tab is selected.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_many :tabs, lambda { |selected: false, **system_arguments|
      system_arguments[:classes] = class_names(
        "tabnav-tab",
        system_arguments[:classes]
      )

      Primer::Navigation::TabComponent.new(
        selected: selected,
        with_panel: @with_panel,
        **system_arguments
      )
    }

    # Renders extra content to the `TabNav`. This will be rendered after the tabs.
    #
    # @param align [Symbol] <%= one_of(Primer::TabNavComponent::EXTRA_ALIGN_OPTIONS) %>
    renders_one :extra, lambda { |align: DEFAULT_EXTRA_ALIGN, &block|
      @align = fetch_or_fallback(EXTRA_ALIGN_OPTIONS, align, DEFAULT_EXTRA_ALIGN)

      view_context.capture { block&.call }
    }

    # @example Default
    #   <%= render(Primer::TabNavComponent.new(label: "Default")) do |c| %>
    #     <% c.tab(selected: true, href: "#") { "Tab 1" }%>
    #     <% c.tab(href: "#") { "Tab 2" } %>
    #     <% c.tab(href: "#") { "Tab 3" } %>
    #   <% end %>
    #
    # @example With icons and counters
    #   <%= render(Primer::TabNavComponent.new(label: "With icons and counters")) do |component| %>
    #     <% component.tab(href: "#", selected: true) do |t| %>
    #       <% t.icon(icon: :star) %>
    #       <% t.text { "Item 1" } %>
    #     <% end %>
    #     <% component.tab(href: "#") do |t| %>
    #       <% t.icon(icon: :star) %>
    #       <% t.text { "Item 2" } %>
    #       <% t.counter(count: 10) %>
    #     <% end %>
    #     <% component.tab(href: "#") do |t| %>
    #       <% t.text { "Item 3" } %>
    #       <% t.counter(count: 10) %>
    #     <% end %>
    #   <% end %>
    #
    # @example With panels
    #   <%= render(Primer::TabNavComponent.new(label: "With panels", with_panel: true)) do |c| %>
    #     <% c.tab(selected: true, id: "tab-1") do |t| %>
    #       <% t.text { "Tab 1" } %>
    #       <% t.panel do %>
    #         Panel 1
    #       <% end %>
    #     <% end %>
    #     <% c.tab(id: "tab-2") do |t| %>
    #       <% t.text { "Tab 2" } %>
    #       <% t.panel do %>
    #         Panel 2
    #       <% end %>
    #     <% end %>
    #     <% c.tab(id: "tab-3") do |t| %>
    #       <% t.text { "Tab 3" } %>
    #       <% t.panel do %>
    #         Panel 3
    #       <% end %>
    #     <% end %>
    #   <% end %>
    #
    # @example With extra content
    #   <%= render(Primer::TabNavComponent.new(label: "With extra content")) do |c| %>
    #     <% c.tab(selected: true, href: "#") { "Tab 1" }%>
    #     <% c.tab(href: "#") { "Tab 2" } %>
    #     <% c.tab(href: "#") { "Tab 3" } %>
    #     <% c.extra do %>
    #       <%= render(Primer::ButtonComponent.new(float: :right)) { "Button" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example Adding extra content after the tabs
    #   <%= render(Primer::TabNavComponent.new(label: "Adding extra content after the tabs", display: :flex, body_arguments: { flex: 1 })) do |c| %>
    #     <% c.tab(selected: true, href: "#") { "Tab 1" }%>
    #     <% c.tab(href: "#") { "Tab 2" } %>
    #     <% c.tab(href: "#") { "Tab 3" } %>
    #     <% c.extra(align: :right) do %>
    #       <div>
    #         <%= render(Primer::ButtonComponent.new) { "Button" } %>
    #       </div>
    #     <% end %>
    #   <% end %>
    #
    # @example Customizing the body
    #   <%= render(Primer::TabNavComponent.new(label: "Default", body_arguments: { classes: "custom-class", border: true, border_color: :info })) do |c| %>
    #     <% c.tab(selected: true, href: "#") { "Tab 1" }%>
    #     <% c.tab(href: "#") { "Tab 2" } %>
    #     <% c.tab(href: "#") { "Tab 3" } %>
    #   <% end %>
    #
    # @example Customizing the wrapper
    #   <%= render(Primer::TabNavComponent.new(label: "Default", wrapper_arguments: { classes: "custom-class", border: true, border_color: :info })) do |c| %>
    #     <% c.tab(selected: true, href: "#") { "Tab 1" }%>
    #     <% c.tab(href: "#") { "Tab 2" } %>
    #     <% c.tab(href: "#") { "Tab 3" } %>
    #   <% end %>
    #
    # @param label [String] Used to set the `aria-label` on the top level `<nav>` element.
    # @param with_panel [Boolean] Whether the TabNav should navigate through pages or panels. When true, <%= link_to_component(Primer::TabContainerComponent) %>
    #   is rendered along with JavaScript behavior. Additionally, the `tab` slot will render as a button as opposed to an anchor.
    # @param body_arguments [Hash] <%= link_to_system_arguments_docs %> for the body wrapper.
    # @param wrapper_arguments [Hash] <%= link_to_system_arguments_docs %> for the `TabContainer` wrapper. Only applies if `with_panel` is `true`.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(label:, with_panel: false, body_arguments: {}, wrapper_arguments: {}, **system_arguments)
      @align = DEFAULT_EXTRA_ALIGN
      @with_panel = with_panel
      @system_arguments = system_arguments
      @body_arguments = body_arguments
      @wrapper_arguments = wrapper_arguments

      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        "tabnav",
        system_arguments[:classes]
      )

      @body_arguments[:tag] = navigation_tag(with_panel)
      @body_arguments[:"aria-label"] = label
      @body_arguments[:role] = :tablist if @with_panel
      @body_arguments[:classes] = class_names(
        "tabnav-tabs",
        body_arguments[:classes]
      )
    end
  end
end
