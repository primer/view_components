# frozen_string_literal: true

module Primer
  module Alpha
    # Use `UnderlineNav` to style navigation links with a minimal
    # underlined selected state, typically placed at the top
    # of the page.
    #
    # For panel navigation, use <%= link_to_component(Primer::Alpha::UnderlinePanels) %> instead.
    #
    # @accessibility
    #   - By default, `UnderlineNav` renders links within a `<nav>` element. `<nav>` has an
    #     implicit landmark role of `navigation` which should be reserved for main links.
    #     For all other set of links, set tag to `:div`.
    #   - See <%= link_to_component(Primer::Navigation::TabComponent) %> for additional
    #     accessibility considerations.
    class UnderlineNav < Primer::Component
      include Primer::TabbedComponentHelper
      include Primer::UnderlineNavHelper

      BODY_TAG_DEFAULT = :ul

      TAG_DEFAULT = :nav
      TAG_OPTIONS = [TAG_DEFAULT, :div].freeze

      # Use the tabs to list page links.
      #
      # @param selected [Boolean] Whether the tab is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :tabs, lambda { |selected: false, **system_arguments|
        system_arguments[:classes] = underline_nav_tab_classes(system_arguments[:classes])
        Primer::Navigation::TabComponent.new(
          list: true,
          selected: selected,
          icon_classes: "UnderlineNav-octicon",
          **system_arguments
        )
      }

      # Use actions for a call to action.
      #
      # @param tag [Symbol] (Primer::UnderlineNavHelper::ACTIONS_TAG_DEFAULT) <%= one_of(Primer::UnderlineNavHelper::ACTIONS_TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :actions, lambda { |tag: ACTIONS_TAG_DEFAULT, **system_arguments|
        system_arguments[:tag] = fetch_or_fallback(ACTIONS_TAG_OPTIONS, tag, ACTIONS_TAG_DEFAULT)
        system_arguments[:classes] = underline_nav_action_classes(system_arguments[:classes])

        Primer::BaseComponent.new(**system_arguments)
      }

      # @example Default with `<nav>`
      #   @description
      #     `<nav>` is a landmark and should be reserved for main navigation links. See <%= link_to_accessibility %>.
      #   @code
      #     <%= render(Primer::Alpha::UnderlineNav.new(label: "Default with nav element")) do |component| %>
      #       <% component.with_tab(href: "#", selected: true) { "Item 1" } %>
      #       <% component.with_tab(href: "#") { "Item 2" } %>
      #       <% component.with_actions do %>
      #         <%= render(Primer::ButtonComponent.new) { "Button!" } %>
      #       <% end %>
      #     <% end %>
      #
      # @example With `<div>`
      #   <%= render(Primer::Alpha::UnderlineNav.new(tag: :div, label: "With div element")) do |component| %>
      #     <% component.with_tab(href: "#", selected: true) { "Item 1" } %>
      #     <% component.with_tab(href: "#") { "Item 2" } %>
      #     <% component.with_actions do %>
      #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
      #     <% end %>
      #   <% end %>
      #
      # @example With icons and counters
      #   <%= render(Primer::Alpha::UnderlineNav.new(label: "With icons and counters")) do |component| %>
      #     <% component.with_tab(href: "#", selected: true) do |t| %>
      #       <% t.icon(icon: :star) %>
      #       <% t.text { "Item 1" } %>
      #     <% end %>
      #     <% component.with_tab(href: "#") do |t| %>
      #       <% t.icon(icon: :star) %>
      #       <% t.text { "Item 2" } %>
      #       <% t.counter(count: 10) %>
      #     <% end %>
      #     <% component.with_tab(href: "#") do |t| %>
      #       <% t.text { "Item 3" } %>
      #       <% t.counter(count: 10) %>
      #     <% end %>
      #     <% component.with_actions do %>
      #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
      #     <% end %>
      #   <% end %>
      #
      # @example Align right
      #   <%= render(Primer::Alpha::UnderlineNav.new(label: "Align right", align: :right)) do |component| %>
      #     <% component.with_tab(href: "#", selected: true) do |t| %>
      #       <% t.text { "Item 1" } %>
      #     <% end %>
      #     <% component.with_tab(href: "#") do |t| %>
      #       <% t.text { "Item 2" } %>
      #     <% end %>
      #     <% component.with_actions do %>
      #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
      #     <% end %>
      #   <% end %>
      #
      # @example Customizing the body
      #   <%= render(Primer::Alpha::UnderlineNav.new(label: "Default", body_arguments: { classes: "custom-class", border: true, border_color: :accent_emphasis })) do |component| %>
      #     <% component.with_tab(selected: true, href: "#") { "Tab 1" }%>
      #     <% component.with_tab(href: "#") { "Tab 2" } %>
      #     <% component.with_tab(href: "#") { "Tab 3" } %>
      #   <% end %>
      #
      # @param tag [Symbol] <%= one_of(Primer::Alpha::UnderlineNav::TAG_OPTIONS) %>
      # @param label [String] Sets an `aria-label` that helps assistive technology users understand the purpose of the links, and distinguish it from similar elements.
      # @param align [Symbol] <%= one_of(Primer::UnderlineNavHelper::ALIGN_OPTIONS) %> - Defaults to <%= Primer::UnderlineNavHelper::ALIGN_DEFAULT %>
      # @param body_arguments [Hash] <%= link_to_system_arguments_docs %> for the body wrapper.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(label:, tag: TAG_DEFAULT, align: ALIGN_DEFAULT, body_arguments: {}, **system_arguments)
        @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)

        @system_arguments = system_arguments
        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
        @system_arguments[:classes] = underline_nav_classes(@system_arguments[:classes], @align)

        @body_arguments = body_arguments
        @body_arguments[:tag] = :ul
        @body_arguments[:classes] = underline_nav_body_classes(@body_arguments[:classes])

        aria_label_for_page_nav(label)
      end

      private

      def body
        Primer::BaseComponent.new(**@body_arguments)
      end
    end
  end
end
