# frozen_string_literal: true

module Primer
  class SelectMenuComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :modal, class_name: "Modal"

    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        "SelectMenu",
        kwargs[:classes]
      )
    end

    def render?
      modal.present?
    end

    class Modal < Primer::Slot
      def initialize(**kwargs)
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
          classes: class_names(
            "SelectMenu-list",
            @kwargs[:list_classes],
          )
        )
      end
    end

    def component
      Primer::BaseComponent.new(**@kwargs)
    end
  end
end
