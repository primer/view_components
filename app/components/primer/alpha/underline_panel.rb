# frozen_string_literal: true

module Primer
  module Alpha
    # Use `UnderlinePanel` to style tabs with an associated panel and an underlined selected state.
    class UnderlinePanel < Primer::Component
      include Primer::TabbedComponentHelper
      include Primer::UnderlineNavHelper
      # Use to render a button and an associated panel slot. See the example below or refer to <%= link_to_component(Primer::Navigation::TabComponent) %>.
      #
      # @param id [String] Unique ID of tab.
      # @param selected [Boolean] Whether the tab is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :tabs, lambda { |id:, selected: false, **system_arguments, &block|
        system_arguments[:id] = id
        system_arguments[:classes] = underline_nav_tab_classes(system_arguments[:classes])

        @underline_nav.tab(
          selected: selected,
          with_panel: true,
          list: true,
          icon_classes: "UnderlineNav-octicon",
          panel_id: "panel-#{id}",
          **system_arguments,
          &block
        )
      }

      # Use actions for a call to action.
      #
      # @param tag [Symbol] (Primer::Alpha::UnderlinePanel::ACTIONS_TAG_DEFAULT) <%= one_of(Primer::Alpha::UnderlinePanel::ACTIONS_TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :actions, lambda { |tag: ACTIONS_TAG_DEFAULT, **system_arguments, &block|
        @underline_nav.actions(tag: tag, **system_arguments, &block)
      }

      # @example Default
      #   <%= render(Primer::Alpha::UnderlinePanel.new(label: "With panels")) do |component| %>
      #     <% component.tab(id: "tab-1", selected: true) do |t| %>
      #       <% t.text { "Tab 1" } %>
      #       <% t.panel do %>
      #         Panel 1
      #       <% end %>
      #     <% end %>
      #     <% component.tab(id: "tab-2") do |t| %>
      #       <% t.text { "Tab 2" } %>
      #       <% t.panel do %>
      #         Panel 2
      #       <% end %>
      #     <% end %>
      #     <% component.actions do %>
      #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
      #     <% end %>
      #   <% end %>
      #
      # @param label [String] Used to set the `aria-label` on top level element.
      # @param align [Symbol] <%= one_of(Primer::Alpha::UnderlinePanel::ALIGN_OPTIONS) %> - Defaults to <%= Primer::Alpha::UnderlinePanel::ALIGN_DEFAULT %>
      # @param body_arguments [Hash] <%= link_to_system_arguments_docs %> for the body wrapper.
      # @param wrapper_arguments [Hash] <%= link_to_system_arguments_docs %> for the `TabContainer` wrapper.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(label:, align: ALIGN_DEFAULT, body_arguments: {}, wrapper_arguments: {}, **system_arguments)
        @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)
        @wrapper_arguments = wrapper_arguments

        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = underline_nav_classes(@system_arguments[:classes], @align)

        @body_arguments = body_arguments
        @body_arguments[:tag] = :ul
        @body_arguments[:classes] = underline_nav_body_classes(@body_arguments[:classes])

        @body_arguments[:role] = :tablist
        @body_arguments[:"aria-label"] = label

        @underline_nav = Primer::Alpha::UnderlineNav.new(
          tag: :div,
          label: label,
          align: @align,
          body_arguments: @body_arguments,
          **@system_arguments
        )
      end

      private

      def body
        Primer::BaseComponent.new(**@body_arguments)
      end
    end
  end
end
