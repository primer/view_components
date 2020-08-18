# frozen_string_literal: true

module Primer
  class PopoverComponent < Primer::Component
    include ViewComponent::Slotable

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

    with_content_areas :heading, :body, :button
    with_slot :message

    class Message < ViewComponent::Slot
      attr_reader :kwargs

      def initialize(caret: CARET_DEFAULT, **kwargs)
        @kwargs = kwargs
        @kwargs[:classes] = class_names(
          kwargs[:classes],
          "Popover-message text-left p-4 mt-2 mx-auto Box box-shadow-large",
          CARET_MAPPINGS[fetch_or_fallback(CARET_MAPPINGS.keys, caret, CARET_DEFAULT)]
        )
      end
    end

    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        kwargs[:classes],
        "Popover right-0 left-0 position-relative"
      )

      @heading_kwargs = { tag: :h4, classes: "mb-2" }
      @button_kwargs = { tag: :button, type: "button", classes: "btn btn-outline mt-2 text-bold" }
    end
  end
end
