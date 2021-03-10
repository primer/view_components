# frozen_string_literal: true

module Primer
  # Use `TimelineItem` to display items on a vertical timeline, connected by badge elements.
  class TimelineItemComponent < Primer::Component
    include ViewComponent::SlotableV2
    status :beta

    # Avatar to be rendered to the left of the Badge.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::AvatarComponent) %>.
    renders_one :avatar, lambda { |src:, size: 40, square: true, **system_arguments|
      system_arguments[:classes] = class_names(
        "TimelineItem-avatar",
        system_arguments[:classes]
      )

      Primer::AvatarComponent.new(src: src, size: size, square: square, **system_arguments)
    }

    # Badge that will be connected to other TimelineItems.
    #
    # @param icon [String] Name of [Octicon](https://primer.style/octicons/) to use.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :badge, "BadgeComponent"

    # Body to be rendered to the left of the Badge.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :body, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(
        "TimelineItem-body",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #   <div style="padding-left: 60px">
    #     <%= render(Primer::TimelineItemComponent.new) do |component| %>
    #       <% component.avatar(src: "https://github.com/github.png", alt: "github") %>
    #       <% component.badge(bg: :success_inverse, color: :white, icon: :check) %>
    #       <% component.body { "Success!" } %>
    #     <% end %>
    #   </div>
    #
    # @param condensed [Boolean] Reduce the vertical padding and remove the background from the badge item. Most commonly used in commits.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(condensed: false, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        "TimelineItem",
        condensed ? "TimelineItem--condensed" : "",
        system_arguments[:classes]
      )
    end

    def render?
      avatar.present? || badge.present? || body.present?
    end

    # This component is part of `Primer::TimelineItemComponent` and should not be
    # used as a standalone component.
    class BadgeComponent < Primer::Component
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
