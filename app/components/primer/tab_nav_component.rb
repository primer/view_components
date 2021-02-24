# frozen_string_literal: true

module Primer
  # Use TabNav to style navigation with a tab-based selected state, typically used for navigation placed at the top of the page.
  class TabNavComponent < Primer::Component
    include ViewComponent::SlotableV2

    # Tabs to be rendered.
    #
    # @param title [String] Text to be rendered by the tab.
    # @param selected [Boolean] Whether the tab is selected.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_many :tabs, -> (**system_arguments) do
      return TabComponent.new(**system_arguments) unless @with_panel

      TabComponent.new(tag: :button, type: :button, **system_arguments)
    end

    # @example auto|Default
    #   <%= render(Primer::TabNavComponent.new) do |c| %>
    #     <% c.tab(selected: true, title: "Tab 1", href: "#") %>
    #     <% c.tab(title: "Tab 2", href: "#") %>
    #     <% c.tab(title: "Tab 3", href: "#") %>
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
        system_arguments[:classes],
      )
    end

    def render?
      tabs.any?
    end

    def wrapper
      @with_panel ? Primer::TabContainerComponent : Primer::BaseComponent
    end

    class TabComponent < Primer::Component
      def initialize(title:, selected: false, **system_arguments)
        @title = title
        @selected = selected
        @system_arguments = system_arguments
        @system_arguments[:tag] ||= :a
        @system_arguments[:role] = :tab

        if selected
          if @system_arguments[:tag] == :a
            @system_arguments[:"aria-current"] = :page
          else
            @system_arguments[:"aria-selected"] = true
          end
        end

        @system_arguments[:classes] = class_names(
          "tabnav-tab",
          system_arguments[:classes],
        )
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { @title }
      end

      def panel
        content
      end

      def hidden?
        !@selected
      end
    end
  end
end
