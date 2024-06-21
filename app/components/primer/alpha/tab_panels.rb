# frozen_string_literal: true

module Primer
  module Alpha
    # Use `TabPanels` for tabs with panel navigation.
    class TabPanels < Primer::Component
      include Primer::TabbedComponentHelper
      include Primer::TabNavHelper

      status :alpha

      BODY_TAG_DEFAULT = :ul

      TAG_DEFAULT = :nav
      TAG_OPTIONS = [TAG_DEFAULT, :div].freeze

      # Tabs to be rendered. For more information, refer to <%= link_to_component(Primer::Alpha::Navigation::Tab) %>.
      #
      # @param id [String] Unique ID of tab.
      # @param selected [Boolean] Whether the tab is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :tabs, lambda { |id:, selected: false, **system_arguments|
        system_arguments[:id] = id
        system_arguments[:classes] = tab_nav_tab_classes(system_arguments[:classes])

        Primer::Alpha::Navigation::Tab.new(
          selected: selected,
          with_panel: true,
          list: true,
          panel_id: "panel-#{id}",
          **system_arguments
        )
      }

      # Renders extra content to the `TabPanels`. This will be rendered after the tabs.
      #
      # @param align [Symbol] <%= one_of(Primer::Alpha::TabNav::EXTRA_ALIGN_OPTIONS) %>
      renders_one :extra, lambda { |align: EXTRA_ALIGN_DEFAULT, &block|
        @align = fetch_or_fallback(EXTRA_ALIGN_OPTIONS, align, EXTRA_ALIGN_DEFAULT)

        view_context.capture { block&.call }
      }

      # @param label [String] Sets an `aria-label` that helps assistive technology users understand the purpose of the tabs.
      # @param align [Symbol] <%= one_of(Primer::TabNavHelper::EXTRA_ALIGN_OPTIONS) %> - Defaults to <%= Primer::TabNavHelper::EXTRA_ALIGN_DEFAULT %>
      # @param body_arguments [Hash] <%= link_to_system_arguments_docs %> for the body wrapper.
      # @param wrapper_arguments [Hash] <%= link_to_system_arguments_docs %> for the `TabContainer` wrapper.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(label:, body_arguments: {}, wrapper_arguments: {}, **system_arguments)
        @align = EXTRA_ALIGN_DEFAULT
        @wrapper_arguments = wrapper_arguments

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = tab_nav_classes(@system_arguments[:classes])

        @body_arguments = deny_tag_argument(**body_arguments)
        @body_arguments[:tag] = :ul
        @body_arguments[:classes] = tab_nav_body_classes(@body_arguments[:classes])

        @body_arguments[:role] = :tablist
        @body_arguments[:"aria-label"] = label
      end

      def before_render
        # Eagerly evaluate content to avoid https://github.com/primer/view_components/issues/1790
        content

        super
      end
    end
  end
end
