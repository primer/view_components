# frozen_string_literal: true

module Primer
  class PopoverComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :heading, class_name: "Heading"
    with_slot :body, class_name: "Body"

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
