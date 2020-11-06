# frozen_string_literal: true

module Primer
  # Use popovers to bring attention to specific user interface elements, typically to suggest an action or to guide users through a new experience.
  #
  # By default, the popover renders with absolute positioning, meaning it should usually be wrapped in an element with a relative position in order to be positioned properly. To render the popover with relative positioning, use the relative property.
  class PopoverComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :heading, class_name: "Heading"
    with_slot :body, class_name: "Body"

    # @example 150|Default
    #   <%= render Primer::PopoverComponent.new do |component| %>
    #     <% component.slot(:heading) do %>
    #       Activity feed
    #     <% end %>
    #     <% component.slot(:body) do %>
    #       This is the Popover body.
    #     <% end %>
    #   <% end %>
    #
    # @example 150|Large
    #   <%= render Primer::PopoverComponent.new do |component| %>
    #     <% component.slot(:heading) do %>
    #       Activity feed
    #     <% end %>
    #     <% component.slot(:body, large: true) do %>
    #       This is the large Popover body.
    #     <% end %>
    #   <% end %>
    #
    # @example 150|Caret position
    #   <%= render Primer::PopoverComponent.new do |component| %>
    #     <% component.slot(:heading) do %>
    #       Activity feed
    #     <% end %>
    #     <% component.slot(:body, caret: :left) do %>
    #       This is the large Popover body.
    #     <% end %>
    #   <% end %>
    #
    # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] ||= :div
      @kwargs[:classes] = class_names(
        kwargs[:classes],
        "Popover"
      )
      @kwargs[:position] ||= :relative
      @kwargs[:right] = false unless kwargs.key?(:right)
      @kwargs[:left] = false unless kwargs.key?(:left)
    end

    def render?
      body.present?
    end

    class Heading < ViewComponent::Slot
      # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:mb] ||= 2
        @kwargs[:tag] ||= :h4
      end

      def component
        Primer::HeadingComponent.new(**@kwargs)
      end
    end

    class Body < Slot
      CARET_DEFAULT = :top
      CARET_MAPPINGS = {
        CARET_DEFAULT => "",
        :bottom => "Popover-message--bottom",
        :bottom_right => "Popover-message--bottom-right",
        :bottom_left => "Popover-message--bottom-left",
        :left => "Popover-message--left",
        :left_bottom => "Popover-message--left-bottom",
        :left_top => "Popover-message--left-top",
        :right => "Popover-message--right",
        :right_bottom => "Popover-message--right-bottom",
        :right_top => "Popover-message--right-top",
        :top_left => "Popover-message--top-left",
        :top_right => "Popover-message--top-right"
      }.freeze

      # @param caret [Symbol] <%= one_of(Primer::PopoverComponent::Body::CARET_MAPPINGS.keys) %>
      # @param large [Boolean] Whether to use the large version of the component.
      # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
      def initialize(caret: CARET_DEFAULT, large: false, **kwargs)
        @kwargs = kwargs
        @kwargs[:classes] = class_names(
          kwargs[:classes],
          "Popover-message Box",
          CARET_MAPPINGS[fetch_or_fallback(CARET_MAPPINGS.keys, caret, CARET_DEFAULT)],
          "Popover-message--large" => large
        )
        @kwargs[:p] ||= 4
        @kwargs[:mt] ||= 2
        @kwargs[:mx] ||= :auto
        @kwargs[:text_align] ||= :left
        @kwargs[:box_shadow] ||= :large
      end

      def component
        Primer::BoxComponent.new(**@kwargs)
      end
    end
  end
end
