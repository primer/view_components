# frozen_string_literal: true

module Primer
  module Alpha
    # Use `UnderlinePanels` to style tabs with an associated panel and an underlined selected state.
    class UnderlinePanels < Primer::Component
      include Primer::TabbedComponentHelper
      include Primer::UnderlineNavHelper
      # Use to render a button and an associated panel slot. See the example below or refer to <%= link_to_component(Primer::Alpha::Navigation::Tab) %>.
      #
      # @param id [String] Unique ID of tab.
      # @param selected [Boolean] Whether the tab is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :tabs, lambda { |id:, selected: false, **system_arguments|
        system_arguments[:id] = id
        system_arguments[:classes] = underline_nav_tab_classes(system_arguments[:classes])

        Primer::Alpha::Navigation::Tab.new(
          selected: selected,
          with_panel: true,
          list: false,
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

      # @param label [String] Sets an `aria-label` that helps assistive technology users understand the purpose of the tabs.
      # @param align [Symbol] <%= one_of(Primer::UnderlineNavHelper::ALIGN_OPTIONS) %> - Defaults to <%= Primer::UnderlineNavHelper::ALIGN_DEFAULT %>
      # @param body_arguments [Hash] <%= link_to_system_arguments_docs %> for the body wrapper.
      # @param wrapper_arguments [Hash] <%= link_to_system_arguments_docs %> for the `TabContainer` wrapper.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(label:, align: ALIGN_DEFAULT, body_arguments: {}, wrapper_arguments: {}, **system_arguments)
        @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)
        @wrapper_arguments = wrapper_arguments
        @wrapper_arguments[:tag] = :div

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :"tab-container"
        @system_arguments[:classes] = underline_nav_classes(@system_arguments[:classes], @align)
        @system_arguments[:"aria-label"] = label

        @body_arguments = deny_tag_argument(**body_arguments)
        @body_arguments[:tag] = :div
      end
    end
  end
end
