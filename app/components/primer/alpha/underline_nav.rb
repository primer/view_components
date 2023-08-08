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
    #   - See <%= link_to_component(Primer::Alpha::Navigation::Tab) %> for additional
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
        Primer::Alpha::Navigation::Tab.new(
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
