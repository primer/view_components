# frozen_string_literal: true

module Primer
  class BorderBoxComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :title, :body, :footer
    with_slot :row, collection: true, class_name: "BorderBoxRow"

    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        "Box",
        kwargs[:classes]
      )
    end

    class BorderBoxRow < ViewComponent::Slot
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :li
        @kwargs[:classes] = class_names(
          "Box-row",
          kwargs[:classes]
        )
      end
    end
  end
end
