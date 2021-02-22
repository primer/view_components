# frozen_string_literal: true

require_relative 'timeline_item/badge_component'

module Primer
  # Use `TimelineItem` to display items on a vertical timeline, connected by badge elements.
  class TimelineItemComponent < Primer::Component
    include ViewComponent::SlotableV2

    # Optional Avatar to be rendered besides the badge.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::AvatarComponent) %>.
    renders_one :avatar, lambda { |src:, size: 40, square: true, **system_arguments|
      @system_arguments[:classes] = class_names(
        "TimelineItem-avatar",
        system_arguments[:classes]
      )

      Primer::AvatarComponent.new(src: src, size: size, square: square, **system_arguments)
    }

    # Required Badge
    renders_one :badge, Primer::TimelineItem::BadgeComponent
    renders_one :body, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(
        "TimelineItem-body",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    attr_reader :system_arguments

    # @example auto|Default
    #   <div style="padding-left: 60px">
    #     <%= render(Primer::TimelineItemComponent.new) do |component| %>
    #       <% component.avatar(src: "https://github.com/github.png", alt: "github") %>
    #       <% component.badge(bg: :green, color: :white, icon: :check) %>
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
  end
end
