# frozen_string_literal: true

module Primer
  # Use ProgressBar to visualize task completion.
  class ProgressBarComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :item, collection: true, class_name: "Item"

    SIZE_DEFAULT = :default

    SIZE_MAPPINGS = {
      SIZE_DEFAULT => "",
      :small => "Progress--small",
      :large => "Progress--large",
    }.freeze

    SIZE_OPTIONS = SIZE_MAPPINGS.keys
    # @example 20|Default
    #   <%= render(Primer::ProgressBarComponent.new) do |component| %>
    #     <% component.slot(:item, percentage: 25) %>
    #   <% end %>
    #
    # @example 20|Small
    #   <%= render(Primer::ProgressBarComponent.new(size: :small)) do |component| %>
    #     <% component.slot(:item, bg: :blue_4, percentage: 50) %>
    #   <% end %>
    #
    # @example 30|Large
    #   <%= render(Primer::ProgressBarComponent.new(size: :large)) do |component| %>
    #     <% component.slot(:item, bg: :red_4, percentage: 75) %>
    #   <% end %>
    #
    # @example 20|Multiple items
    #   <%= render(Primer::ProgressBarComponent.new) do |component| %>
    #     <% component.slot(:item, percentage: 10) %>
    #     <% component.slot(:item, bg: :blue_4, percentage: 20) %>
    #     <% component.slot(:item, bg: :red_4, percentage: 30) %>
    #   <% end %>
    #
    # @param size [Symbol] <%= one_of(Primer::ProgressBarComponent::SIZE_OPTIONS) %> Increases height.
    # @param kwargs [Hash] <%= link_to_style_arguments_docs %>
    def initialize(size: SIZE_DEFAULT, **kwargs)
      @kwargs = kwargs
      @kwargs[:classes] = class_names(
        @kwargs[:classes],
        "Progress",
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
      )
      @kwargs[:tag] = :span

    end

    def render?
      items.any?
    end

    class Item < ViewComponent::Slot
      include ClassNameHelper
      attr_reader :kwargs

      # @param percentage [Integer] Percentage completion of item.
      # @param bg [Symbol] Color of item.
      # @param kwargs [Hash] <%= link_to_style_arguments_docs %>
      def initialize(percentage: 0, bg: :green, **kwargs)
        @percentage = percentage
        @kwargs = kwargs

        @kwargs[:tag] = :span
        @kwargs[:bg] = bg
        @kwargs[:style] = "width: #{@percentage}%;"
        @kwargs[:classes] = class_names("Progress-item", @kwargs[:classes])
      end
    end
  end
end
