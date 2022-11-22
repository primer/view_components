# frozen_string_literal: true

module Primer
  module Alpha
    # `OrderedList` is a list component with ordered items.
    class OrderedList < Primer::Component
      status :alpha

      ORDER_TYPE_DEFAULT = :decimal
      ORDER_TYPE_MAPPINGS = {
        ORDER_TYPE_DEFAULT => "OrderedList--type-decimal",
        :upper_alpha => "OrderedList--type-upperAlpha",
        :lower_alpha => "OrderedList--type-lowerAlpha",
        :upper_roman => "OrderedList--type-upperRoman",
        :lower_roman => "OrderedList--type-lowerRoman"
      }.freeze
      ORDER_TYPE_OPTIONS = ORDER_TYPE_MAPPINGS.keys.freeze

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
      # @param type [Symbol] <%= one_of(Primer::Alpha::OrderedList::ORDER_TYPE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(type: ORDER_TYPE_DEFAULT, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :ol
        @system_arguments[:classes] = class_names(
          "OrderedList",
          ORDER_TYPE_MAPPINGS[fetch_or_fallback(ORDER_TYPE_OPTIONS, type, ORDER_TYPE_DEFAULT)],
          system_arguments[:classes]
        )
      end

      def render?
        items.any?
      end
    end
  end
end
