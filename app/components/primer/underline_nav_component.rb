# frozen_string_literal: true

module Primer
  # Use `UnderlineNav` to style navigation with a minimal
  # underlined selected state, typically used for navigation placed at the top
  # of the page.
  class UnderlineNavComponent < Primer::Component
    include Primer::TabbedComponentHelper

    ALIGN_DEFAULT = :left
    ALIGN_OPTIONS = [ALIGN_DEFAULT, :right].freeze

    BODY_TAG_DEFAULT = :div
    BODY_TAG_OPTIONS = [BODY_TAG_DEFAULT, :ul].freeze

    ACTIONS_TAG_DEFAULT = :div
    ACTIONS_TAG_OPTIONS = [ACTIONS_TAG_DEFAULT, :span].freeze

    # Use the tabs to list navigation items. When `with_panel` is set on the parent, a button is rendered for panel navigation. Otherwise,
    # an anchor tag is rendered for page navigation. For more information, refer to <%= link_to_component(Primer::Navigation::TabComponent) %>.
    #
    # @param selected [Boolean] Whether the tab is selected.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_many :tabs, lambda { |selected: false, **system_arguments|
      system_arguments[:classes] = class_names(
        "UnderlineNav-item",
        system_arguments[:classes]
      )

      Primer::Navigation::TabComponent.new(
        list: list?,
        selected: selected,
        with_panel: @with_panel,
        icon_classes: "UnderlineNav-octicon",
        **system_arguments
      )
    }

    # Use actions for a call to action.
    #
    # @param tag [Symbol] (Primer::UnderlineNavComponent::ACTIONS_TAG_DEFAULT) <%= one_of(Primer::UnderlineNavComponent::ACTIONS_TAG_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :actions, lambda { |tag: ACTIONS_TAG_DEFAULT, **system_arguments|
      system_arguments[:tag] = fetch_or_fallback(ACTIONS_TAG_OPTIONS, tag, ACTIONS_TAG_DEFAULT)
      system_arguments[:classes] = class_names("UnderlineNav-actions", system_arguments[:classes])

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #   <%= render(Primer::UnderlineNavComponent.new(label: "Default")) do |component| %>
    #     <% component.tab(href: "#", selected: true) { "Item 1" } %>
    #     <% component.tab(href: "#") { "Item 2" } %>
    #     <% component.actions do %>
    #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example With icons and counters
    #   <%= render(Primer::UnderlineNavComponent.new(label: "With icons and counters")) do |component| %>
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
    #     <% component.actions do %>
    #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example Align right
    #   <%= render(Primer::UnderlineNavComponent.new(label: "Align right", align: :right)) do |component| %>
    #     <% component.tab(href: "#", selected: true) do |t| %>
    #       <% t.text { "Item 1" } %>
    #     <% end %>
    #     <% component.tab(href: "#") do |t| %>
    #       <% t.text { "Item 2" } %>
    #     <% end %>
    #     <% component.actions do %>
    #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example As a list
    #   <%= render(Primer::UnderlineNavComponent.new(label: "As a list", body_arguments: { tag: :ul })) do |component| %>
    #     <% component.tab(href: "#", selected: true) do |t| %>
    #       <% t.text { "Item 1" } %>
    #     <% end %>
    #     <% component.tab(href: "#") do |t| %>
    #       <% t.text { "Item 2" } %>
    #     <% end %>
    #     <% component.actions do %>
    #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example With panels
    #   <%= render(Primer::UnderlineNavComponent.new(label: "With panels", with_panel: true)) do |component| %>
    #     <% component.tab(selected: true, id: "tab-1") do |t| %>
    #       <% t.text { "Item 1" } %>
    #       <% t.panel do %>
    #         Panel 1
    #       <% end %>
    #     <% end %>
    #     <% component.tab(id: "tab-2") do |t| %>
    #       <% t.text { "Item 2" } %>
    #       <% t.panel do %>
    #         Panel 2
    #       <% end %>
    #     <% end %>
    #     <% component.actions do %>
    #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example Customizing the body
    #   <%= render(Primer::UnderlineNavComponent.new(label: "Default", body_arguments: { tag: :ul, classes: "custom-class", border: true, border_color: :info })) do |c| %>
    #     <% c.tab(selected: true, href: "#") { "Tab 1" }%>
    #     <% c.tab(href: "#") { "Tab 2" } %>
    #     <% c.tab(href: "#") { "Tab 3" } %>
    #   <% end %>
    #
    # @example Customizing the wrapper
    #   <%= render(Primer::UnderlineNavComponent.new(label: "Default", wrapper_arguments: { classes: "custom-class", border: true, border_color: :info })) do |c| %>
    #     <% c.tab(selected: true, href: "#") { "Tab 1" }%>
    #     <% c.tab(href: "#") { "Tab 2" } %>
    #     <% c.tab(href: "#") { "Tab 3" } %>
    #   <% end %>
    #
    # @param label [String] The `aria-label` on top level `<nav>` element.
    # @param with_panel [Boolean] Whether the `UnderlineNav` should navigate through pages or panels. When true, <%= link_to_component(Primer::TabContainerComponent) %> is
    #   rendered along with JavaScript behavior.
    # @param align [Symbol] <%= one_of(Primer::UnderlineNavComponent::ALIGN_OPTIONS) %> - Defaults to <%= Primer::UnderlineNavComponent::ALIGN_DEFAULT %>
    # @param body_arguments [Hash] <%= link_to_system_arguments_docs %> for the body wrapper.
    # @param wrapper_arguments [Hash] <%= link_to_system_arguments_docs %> for the `TabContainer` wrapper. Only applies if `with_panel` is `true`.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(label:, with_panel: false, align: ALIGN_DEFAULT, body_arguments: { tag: BODY_TAG_DEFAULT }, wrapper_arguments: {}, **system_arguments)
      @with_panel = with_panel
      @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)
      @wrapper_arguments = wrapper_arguments

      @system_arguments = system_arguments
      @system_arguments[:tag] = navigation_tag(with_panel)
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "UnderlineNav",
        "UnderlineNav--right" => @align == :right
      )

      @body_arguments = body_arguments
      @body_tag = fetch_or_fallback(BODY_TAG_OPTIONS, body_arguments[:tag]&.to_sym, BODY_TAG_DEFAULT)

      @body_arguments[:tag] = @body_tag
      @body_arguments[:classes] = class_names(
        "UnderlineNav-body",
        @body_arguments[:classes],
        "list-style-none" => list?
      )

      if with_panel
        @body_arguments[:role] = :tablist
        @body_arguments[:"aria-label"] = label
      else
        @system_arguments[:"aria-label"] = label
      end
    end

    private

    def list?
      @body_tag == :ul
    end

    def body
      Primer::BaseComponent.new(**@body_arguments)
    end
  end
end
