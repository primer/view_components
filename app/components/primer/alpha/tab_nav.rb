# frozen_string_literal: true

module Primer
  module Alpha
    # Use `TabNav` to style navigation with a tab-based selected state, typically used for navigation placed at the top of the page.
    # For panel navigation, use <%= link_to_component(Primer::Alpha::TabPanels) %> instead.
    #
    # @accessibility
    #   - By default, `TabNav` renders links within a `<nav>` element. `<nav>` has an
    #     implicit landmark role of `navigation` which should be reserved for main links.
    #     For all other set of links, set tag to `:div`.
    #   - See <%= link_to_component(Primer::Alpha::Navigation::Tab) %> for additional
    #     accessibility considerations.
    class TabNav < Primer::Component
      include Primer::TabbedComponentHelper
      include Primer::TabNavHelper

      status :alpha

      BODY_TAG_DEFAULT = :ul

      TAG_DEFAULT = :nav
      TAG_OPTIONS = [TAG_DEFAULT, :div].freeze

      # Tabs to be rendered. For more information, refer to <%= link_to_component(Primer::Alpha::Navigation::Tab) %>.
      #
      # @param selected [Boolean] Whether the tab is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :tabs, lambda { |selected: false, **system_arguments|
        system_arguments[:classes] = tab_nav_tab_classes(system_arguments[:classes])
        Primer::Alpha::Navigation::Tab.new(
          list: true,
          selected: selected,
          **system_arguments
        )
      }

      # Renders extra content to the `TabNav`. This will be rendered after the tabs.
      #
      # @param align [Symbol] <%= one_of(Primer::Alpha::TabNav::EXTRA_ALIGN_OPTIONS) %>
      renders_one :extra, lambda { |align: EXTRA_ALIGN_DEFAULT, &block|
        @align = fetch_or_fallback(EXTRA_ALIGN_OPTIONS, align, EXTRA_ALIGN_DEFAULT)

        view_context.capture { block&.call }
      }

      # @param tag [Symbol] <%= one_of(Primer::Alpha::TabNav::TAG_OPTIONS) %>
      # @param label [String] Sets an `aria-label` that helps assistive technology users understand the purpose of the links, and distinguish it from similar elements.
      # @param body_arguments [Hash] <%= link_to_system_arguments_docs %> for the body wrapper.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(label:, tag: TAG_DEFAULT, body_arguments: {}, **system_arguments)
        @align = EXTRA_ALIGN_DEFAULT
        @system_arguments = system_arguments
        @body_arguments = body_arguments

        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
        @system_arguments[:classes] = tab_nav_classes(system_arguments[:classes])

        @body_arguments[:tag] = BODY_TAG_DEFAULT
        @body_arguments[:classes] = tab_nav_body_classes(body_arguments[:classes])

        aria_label_for_page_nav(label)
      end

      def before_render
        # Eagerly evaluate content to avoid https://github.com/primer/view_components/issues/1790
        content

        super
      end
    end
  end
end
