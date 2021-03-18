# frozen_string_literal: true

module Primer
  module Navigation
    # This component is part of navigation components such as `Primer::TabNavComponent`
    # and `Primer::UnderlineNavComponent` and should not be used as a standalone component.
    class TabComponent < Primer::Component
      include ViewComponent::SlotableV2

      renders_one :panel, lambda { |**system_arguments|
        system_arguments[:tag] ||= :div
        system_arguments[:role] ||= :tabpanel
        system_arguments[:hidden] = true unless @selected

        Primer::BaseComponent.new(**system_arguments)
      }

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

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
