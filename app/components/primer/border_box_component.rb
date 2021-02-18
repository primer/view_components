# frozen_string_literal: true

module Primer
  # BorderBox is a Box component with a border.
  class BorderBoxComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :header, class_name: "Header"
    with_slot :body, class_name: "Body"
    with_slot :footer, class_name: "Footer"
    with_slot :row, collection: true, class_name: "Row"

    # @example auto|Header, body, rows, and footer
    #   <%= render(Primer::BorderBoxComponent.new) do |component| %>
    #     <% component.slot(:header) do %>
    #       Header
    #     <% end %>
    #     <% component.slot(:body) do %>
    #       Body
    #     <% end %>
    #     <% component.slot(:row) do %>
    #       <% if true %>
    #         Row one
    #       <% end %>
    #     <% end %>
    #     <% component.slot(:row) do %>
    #       Row two
    #     <% end %>
    #     <% component.slot(:footer) do %>
    #       Footer
    #     <% end %>
    #   <% end %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names("Box", system_arguments[:classes])
    end

    def render?
      rows.any? || header.present? || body.present? || footer.present?
    end

    def self.status
      Primer::Component::STATUSES[:beta]
    end

    # :nodoc:
    class Header < Primer::Slot
      attr_reader :system_arguments
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "Box-header",
          system_arguments[:classes]
        )
      end
    end

    # :nodoc:
    class Body < Primer::Slot
      attr_reader :system_arguments
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "Box-body",
          system_arguments[:classes]
        )
      end
    end

    # :nodoc:
    class Footer < Primer::Slot
      attr_reader :system_arguments
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "Box-footer",
          system_arguments[:classes]
        )
      end
    end

    # :nodoc:
    class Row < Primer::Slot
      attr_reader :system_arguments
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :li
        @system_arguments[:classes] = class_names(
          "Box-row",
          system_arguments[:classes]
        )
      end
    end
  end
end
