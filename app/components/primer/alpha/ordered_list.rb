# frozen_string_literal: true

module Primer
  module Alpha
    # `OrderedList` is a list component with ordered items.
    class OrderedList < Primer::Component
      status :alpha

      DEFAULT_ORDER_TYPE = "1"
      ORDER_TYPES = [
        DEFAULT_ORDER_TYPE,
        "a",
        "A",
        "i",
        "I"
      ].freeze

      # Use items to add list items to the ordered list.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :items, Primer::Alpha::List::ListItem

      # @example OrderedList with a list items
      #
      #   <%= render(Primer::Alpha::OrderedList.new) do |component| %>
      #     <% component.with_item do %>
      #       List item 1
      #     <% end %>
      #     <% component.with_item do %>
      #       List item 2
      #     <% end %>
      #   <% end %>
      #
      # @param type [Symbol] <%= one_of(Primer::Alpha::OrderedList::ORDER_TYPES) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(type: DEFAULT_ORDER_TYPE, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :ol
        @system_arguments[:type] = type
        @system_arguments[:classes] = class_names(
          "OrderedList",
          system_arguments[:classes]
        )
      end

      def render?
        items.any?
      end
    end
  end
end
