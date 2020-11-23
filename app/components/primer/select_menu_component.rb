# frozen_string_literal: true

module Primer
  class SelectMenuComponent < Primer::Component
    include ViewComponent::Slotable

    DEFAULT_ALIGN_RIGHT = false

    with_slot :modal, class_name: "Modal"
    with_slot :header, class_name: "Header"

    def initialize(align_right: DEFAULT_ALIGN_RIGHT, **kwargs)
      @align_right = fetch_or_fallback([true, false], align_right, DEFAULT_ALIGN_RIGHT)
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        "SelectMenu",
        kwargs[:classes],
        "right-0" => @align_right
      )
    end

    def render?
      modal.present?
    end

    class Modal < Primer::Slot
      BORDER_CLASSES = {
        all: nil,
        omit_top: "border-top-0",
        none: "SelectMenu-list--borderless",
      }.freeze
      DEFAULT_BORDER_CLASS = :all

      def initialize(border: DEFAULT_BORDER_CLASS, **kwargs)
        @border = fetch_or_fallback(BORDER_CLASSES.keys, border, DEFAULT_BORDER_CLASS)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(
          "SelectMenu-modal",
          kwargs[:classes]
        )
      end

      def outer_component
        Primer::BaseComponent.new(**@kwargs)
      end

      def inner_component
        Primer::BaseComponent.new(
          tag: :div,
          role: "menu",
          classes: class_names(
            "SelectMenu-list",
            @kwargs[:list_classes],
            BORDER_CLASSES[@border]
          )
        )
      end
    end

    class Header < Primer::Slot
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] ||= :header
        @kwargs[:classes] = class_names(
          "SelectMenu-header",
          kwargs[:classes]
        )
      end

      def outer_component
        Primer::BaseComponent.new(**@kwargs)
      end

      def inner_component
        Primer::BaseComponent.new(
          tag: @kwargs[:title_tag] || :h3,
          classes: class_names(
            "SelectMenu-title",
            @kwargs[:title_classes],
          )
        )
      end
    end

    def component
      Primer::BaseComponent.new(**@kwargs)
    end
  end
end
