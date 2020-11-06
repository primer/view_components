# frozen_string_literal: true

module Primer
  # BorderBox is a Box component with a border.
  class BorderBoxComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :header, class_name: "Header"
    with_slot :body, class_name: "Body"
    with_slot :footer, class_name: "Footer"
    with_slot :row, collection: true, class_name: "Row"

    # @example 350|Header, body, rows, and footer
    #   <%= render(Primer::BorderBoxComponent.new) do |component|
    #     component.slot(:header) { "Header" }
    #     component.slot(:body) { "Body" }
    #     component.slot(:row) { "Row one" }
    #     component.slot(:row) { "Row two" }
    #     component.slot(:row) { "Row three" }
    #     component.slot(:footer) { "Footer" }
    #   end %>
    #
    # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
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
      # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
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
      # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
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
      # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
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
      # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
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
