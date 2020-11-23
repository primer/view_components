# frozen_string_literal: true

module Primer
  # Use `TimelineItem` to display items on a vertical timeline, connected by badge elements.
  class TimelineItemComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :avatar, class_name: "Avatar"
    with_slot :badge, class_name: "Badge"
    with_slot :body, class_name: "Body"

    attr_reader :system_arguments

    # @example 75|Default
    #   <div style="padding-left: 60px">
    #     <%= render(Primer::TimelineItemComponent.new) do |component| %>
    #       <% component.slot(:avatar, src: "https://github.com/github.png", alt: "github") %>
    #       <% component.slot(:badge, bg: :green, color: :white, icon: :check) %>
    #       <% component.slot(:body) { "Success!" } %>
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

    class Avatar < Primer::Slot
      attr_reader :system_arguments, :alt, :src, :size, :square

      # @param alt [String] Alt text for avatar image.
      # @param src [String] Src attribute for avatar image.
      # @param size [Integer] Image size.
      # @param square [Boolean] Whether to round the edges of the image.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(alt: nil, src: nil, size: 40, square: true, **system_arguments)
        @alt = alt
        @src = src
        @size = size
        @square = square

        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "TimelineItem-avatar",
          system_arguments[:classes]
        )
      end
    end

    class Badge < Primer::Slot
      attr_reader :system_arguments, :icon

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
    end

    class Body < Primer::Slot
      attr_reader :system_arguments

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "TimelineItem-body",
          system_arguments[:classes]
        )
      end
    end
  end
end
