# frozen_string_literal: true

module Primer
  class BorderBoxComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :header, class_name: "Header"
    with_slot :body, class_name: "Body"
    with_slot :footer, class_name: "Footer"
    with_slot :row, collection: true, class_name: "Row"

    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        "Box",
        kwargs[:classes]
      )
    end

    def render?
      rows.any? || header.present? || body.present? || footer.present?
    end

    class Header < Primer::Slot

      attr_reader :kwargs
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(
          "Box-header",
          kwargs[:classes]
        )
      end
    end

    class Body < Primer::Slot

      attr_reader :kwargs
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(
          "Box-body",
          kwargs[:classes]
        )
      end
    end

    class Footer < Primer::Slot

      attr_reader :kwargs
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(
          "Box-footer",
          kwargs[:classes]
        )
      end
    end

    class Row < Primer::Slot

      attr_reader :kwargs
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
