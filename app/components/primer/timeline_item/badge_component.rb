# frozen_string_literal: true

module Primer
  module TimelineItem
    # This component is part of `Primer::TimelineItemComponent` and should not be
    # used as a standalone component.
    class BadgeComponent < Primer::Component
      # @param icon [String] Name of [Octicon](https://primer.style/octicons/) to use.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(icon: nil, **system_arguments)
        @icon = icon

        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "TimelineItem-badge",
          system_arguments[:classes]
        )
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) do
          render(Primer::OcticonComponent.new(icon: @icon))
        end
      end
    end
  end
end
