# frozen_string_literal: true

module Primer
  module Navigation
    # This component is part of navigation components such as `Primer::TabNavComponent`
    # and `Primer::UnderlineNavComponent` and should not be used as a standalone component.
    class TabComponent < Primer::Component
      include ViewComponent::SlotableV2

      # Panel controlled by the Tab. It will only renderd if `with_panel` is `true`.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :panel, lambda { |**system_arguments|
        system_arguments[:tag] ||= :div
        system_arguments[:role] ||= :tabpanel
        system_arguments[:hidden] = true unless @selected

        Primer::BaseComponent.new(**system_arguments)
      }

      # Icon to be rendered in the Tab left.
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
      renders_one :icon, lambda { |**system_arguments|
        system_arguments[:classes] = class_names(
          "UnderlineNav-octicon"
        )
        Primer::OcticonComponent.new(**system_arguments)
      }

      # The Tab's title.
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::TextComponent) %>.
      renders_one :title, Primer::TextComponent

      # Counter to be rendered in the Tab right.
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::CounterComponent) %>.
      renders_one :counter, Primer::CounterComponent

      attr_reader :selected

      def initialize(selected: false, with_panel: false, **system_arguments)
        @selected = selected
        @system_arguments = system_arguments
        @system_arguments[:role] = :tab

        if with_panel
          @system_arguments[:tag] ||= :button
          @system_arguments[:type] = :button
        else
          @system_arguments[:tag] ||= :a
        end

        return unless @selected

        if @system_arguments[:tag] == :a
          @system_arguments[:"aria-current"] = :page
        else
          @system_arguments[:"aria-selected"] = true
        end
      end

      def render_content?
        !icon && !title && !counter
      end
    end
  end
end
