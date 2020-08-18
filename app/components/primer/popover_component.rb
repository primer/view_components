# frozen_string_literal: true

module Primer
  class PopoverComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :message, :heading, :body, :button

    class Message < ViewComponent::Slot
      CARET_DEFAULT = :none
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

      attr_reader :kwargs

      def initialize(caret: CARET_DEFAULT, **kwargs)
        @kwargs = kwargs
        @kwargs[:classes] = class_names(
          kwargs[:classes],
          "Popover-message text-left Box box-shadow-large",
          CARET_MAPPINGS[fetch_or_fallback(CARET_MAPPINGS.keys, caret, CARET_DEFAULT)]
        )
        @kwargs[:p] = 4 unless kwargs.key?(:p)
        @kwargs[:mt] = 2 unless kwargs.key?(:mt)
        @kwargs[:mx] = "auto" unless kwargs.key?(:mx)
      end
    end

    class Heading < ViewComponent::Slot
      attr_reader :kwargs

      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:mb] = 2 unless kwargs.key?(:mb)
      end
    end

    class Body < ViewComponent::Slot
      attr_reader :kwargs

      def initialize(**kwargs)
        @kwargs = kwargs
      end
    end

    class Button < ViewComponent::Slot
      attr_reader :kwargs, :tag

      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] ||= :button
        @tag = @kwargs[:tag]
        @kwargs[:classes] = class_names(
          kwargs[:classes],
          "btn btn-outline text-bold"
        )
        @kwargs[:mt] = 2 unless kwargs.key?(:mt)
      end
    end

    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        kwargs[:classes],
        "Popover right-0 left-0 position-relative"
      )
    end
  end
end
