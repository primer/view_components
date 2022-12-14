# frozen_string_literal: true

module Primer
  # Use `TimelineItem` to display items on a vertical timeline, connected by badge elements.
  class TimelineItemComponent < Primer::Component
    status :beta

    # Avatar to be rendered to the left of the Badge.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::Beta::Avatar) %>.
    renders_one :avatar, lambda { |src:, size: 40, shape: :square, **system_arguments|
      system_arguments[:classes] = class_names(
        "TimelineItem-avatar",
        system_arguments[:classes]
      )

      Primer::Beta::Avatar.new(src: src, size: size, shape: shape, **system_arguments)
    }

    # Badge that will be connected to other TimelineItems.
    #
    # @param icon [String] Name of <%= link_to_octicons %> to use.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :badge, "BadgeComponent"

    # Body to be rendered to the left of the Badge.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :body, lambda { |**system_arguments|
      deny_tag_argument(**system_arguments)
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
    #       <% component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "github") %>
    #       <% component.with_badge(bg: :success_emphasis, color: :on_emphasis, icon: :check) %>
    #       <% component.with_body { "Success!" } %>
    #     <% end %>
    #   </div>
    #
    # @param condensed [Boolean] Reduce the vertical padding and remove the background from the badge item. Most commonly used in commits.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(condensed: false, **system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        "TimelineItem",
        condensed ? "TimelineItem--condensed" : "",
        system_arguments[:classes]
      )
    end

    def render?
      avatar? || badge? || body?
    end

    # This component is part of `Primer::TimelineItemComponent` and should not be
    # used as a standalone component.
    class BadgeComponent < Primer::Component
      def initialize(icon: nil, **system_arguments)
        @icon = icon

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "TimelineItem-badge",
          system_arguments[:classes]
        )
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) do
          render(Primer::Beta::Octicon.new(@icon))
        end
      end
    end
  end
end
