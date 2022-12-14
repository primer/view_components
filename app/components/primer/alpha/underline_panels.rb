# frozen_string_literal: true

module Primer
  module Alpha
    # Use `UnderlinePanels` to style tabs with an associated panel and an underlined selected state.
    class UnderlinePanels < Primer::Component
      warn_on_deprecated_slot_setter

      include Primer::TabbedComponentHelper
      include Primer::UnderlineNavHelper
      # Use to render a button and an associated panel slot. See the example below or refer to <%= link_to_component(Primer::Navigation::TabComponent) %>.
      #
      # @param id [String] Unique ID of tab.
      # @param selected [Boolean] Whether the tab is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :tabs, lambda { |id:, selected: false, **system_arguments|
        system_arguments[:id] = id
        system_arguments[:classes] = underline_nav_tab_classes(system_arguments[:classes])

        Primer::Navigation::TabComponent.new(
          selected: selected,
          with_panel: true,
          list: true,
          icon_classes: "UnderlineNav-octicon",
          panel_id: "panel-#{id}",
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

      # @example Default
      #   <%= render(Primer::Alpha::UnderlinePanels.new(label: "With panels")) do |component| %>
      #     <% component.with_tab(id: "tab-1", selected: true) do |tab| %>
      #       <% tab.with_text { "Tab 1" } %>
      #       <% tab.with_panel do %>
      #         Panel 1
      #       <% end %>
      #     <% end %>
      #     <% component.with_tab(id: "tab-2") do |tab| %>
      #       <% tab.with_text { "Tab 2" } %>
      #       <% tab.with_panel do %>
      #         Panel 2
      #       <% end %>
      #     <% end %>
      #     <% component.with_actions do %>
      #       <%= render(Primer::ButtonComponent.new) { "Button!" } %>
      #     <% end %>
      #   <% end %>
      #
      # @param label [String] Sets an `aria-label` that helps assistive technology users understand the purpose of the tabs.
      # @param align [Symbol] <%= one_of(Primer::UnderlineNavHelper::ALIGN_OPTIONS) %> - Defaults to <%= Primer::UnderlineNavHelper::ALIGN_DEFAULT %>
      # @param body_arguments [Hash] <%= link_to_system_arguments_docs %> for the body wrapper.
      # @param wrapper_arguments [Hash] <%= link_to_system_arguments_docs %> for the `TabContainer` wrapper.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(label:, align: ALIGN_DEFAULT, body_arguments: {}, wrapper_arguments: {}, **system_arguments)
        @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)
        @wrapper_arguments = wrapper_arguments

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = underline_nav_classes(@system_arguments[:classes], @align)

        @body_arguments = deny_tag_argument(**body_arguments)
        @body_arguments[:tag] = :ul
        @body_arguments[:classes] = underline_nav_body_classes(@body_arguments[:classes])

        @body_arguments[:role] = :tablist
        @body_arguments[:"aria-label"] = label
      end

      private

      def body
        Primer::BaseComponent.new(**@body_arguments)
      end
    end
  end
end
