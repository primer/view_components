# frozen_string_literal: true

module Primer
  module Navigation
    # This component is part of navigation components such as `Primer::TabNavComponent`
    # and `Primer::UnderlineNavComponent` and should not be used by itself.
    #
    # @accessibility
    #   `TabComponent` renders the selected anchor tab with `aria-current="page"` by default.
    #    When the selected tab does not correspond to the current page, such as in a nested inner tab, make sure to use aria-current="true"
    class TabComponent < Primer::Component
      DEFAULT_ARIA_CURRENT_FOR_ANCHOR = :page
      ARIA_CURRENT_OPTIONS_FOR_ANCHOR = [true, DEFAULT_ARIA_CURRENT_FOR_ANCHOR].freeze
      # Panel controlled by the Tab. This will not render anything in the tab itself.
      # It will provide a accessor for the Tab's parent to call and render the panel
      # content in the appropriate place.
      # Refer to `UnderlineNavComponent` and `TabNavComponent` implementations for examples.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :panel, lambda { |**system_arguments|
        system_arguments[:tag] = :div
        system_arguments[:role] ||= :tabpanel
        system_arguments[:hidden] = true unless @selected

        Primer::BaseComponent.new(**system_arguments)
      }

      # Icon to be rendered in the Tab left.
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
      renders_one :icon, lambda { |icon = nil, **system_arguments|
        system_arguments[:classes] = class_names(
          @icon_classes,
          system_arguments[:classes]
        )
        Primer::OcticonComponent.new(icon, **system_arguments)
      }

      # The Tab's text.
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::Beta::Text) %>.
      renders_one :text, Primer::Beta::Text

      # Counter to be rendered in the Tab right.
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::CounterComponent) %>.
      renders_one :counter, Primer::CounterComponent

      attr_reader :selected

      # @example Default
      #   <%= render(Primer::Navigation::TabComponent.new(selected: true)) do |c| %>
      #     <% c.text { "Selected" } %>
      #   <% end %>
      #   <%= render(Primer::Navigation::TabComponent.new) do |c| %>
      #     <% c.text { "Not selected" } %>
      #   <% end %>
      #
      # @example With icons and counters
      #   <%= render(Primer::Navigation::TabComponent.new) do |c| %>
      #     <% c.icon(:star) %>
      #     <% c.text { "Tab" } %>
      #   <% end %>
      #   <%= render(Primer::Navigation::TabComponent.new) do |c| %>
      #     <% c.icon(:star) %>
      #     <% c.text { "Tab" } %>
      #     <% c.counter(count: 10) %>
      #   <% end %>
      #   <%= render(Primer::Navigation::TabComponent.new) do |c| %>
      #     <% c.text { "Tab" } %>
      #     <% c.counter(count: 10) %>
      #   <% end %>
      #
      # @example Inside a list
      #   <%= render(Primer::Navigation::TabComponent.new(list: true)) do |c| %>
      #     <% c.text { "Tab" } %>
      #   <% end %>
      #
      # @example With custom HTML
      #   <%= render(Primer::Navigation::TabComponent.new) do %>
      #     <div>
      #       This is my <strong>custom HTML</strong>
      #     </div>
      #   <% end %>
      #
      # @param list [Boolean] Whether the Tab is an item in a `<ul>` list.
      # @param selected [Boolean] Whether the Tab is selected or not.
      # @param with_panel [Boolean] Whether the Tab has an associated panel.
      # @param icon_classes [Boolean] Classes that must always be applied to icons.
      # @param wrapper_arguments [Hash] <%= link_to_system_arguments_docs %> to be used in the `<li>` wrapper when the tab is an item in a list.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(list: false, selected: false, with_panel: false, icon_classes: "", wrapper_arguments: {}, **system_arguments)
        @selected = selected
        @icon_classes = icon_classes
        @list = list

        @system_arguments = system_arguments

        if with_panel || @system_arguments[:tag] == :button
          @system_arguments[:tag] = :button
          @system_arguments[:type] = :button
          @system_arguments[:role] = :tab
        else
          @system_arguments[:tag] = :a
        end

        @wrapper_arguments = wrapper_arguments
        @wrapper_arguments[:tag] = :li
        @wrapper_arguments[:display] ||= :flex

        return unless @selected

        if @system_arguments[:tag] == :a
          aria_current = @system_arguments[:"aria-current"] || @system_arguments.dig(:aria, :current) || DEFAULT_ARIA_CURRENT_FOR_ANCHOR
          @system_arguments[:"aria-current"] = fetch_or_fallback(ARIA_CURRENT_OPTIONS_FOR_ANCHOR, aria_current, DEFAULT_ARIA_CURRENT_FOR_ANCHOR)
        else
          @system_arguments[:"aria-selected"] = true
        end
      end

      def wrapper
        unless @list
          yield
          return # returning `yield` caused a double render
        end

        render(Primer::BaseComponent.new(**@wrapper_arguments)) do
          yield
        end
      end
    end
  end
end
