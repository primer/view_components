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
      :large => "Progress--large"
    }.freeze

    SIZE_OPTIONS = SIZE_MAPPINGS.keys
    # @example Default
    #   <%= render(Primer::ProgressBarComponent.new) do |component| %>
    #     <% component.slot(:item, percentage: 25) %>
    #   <% end %>
    #
    # @example Small
    #   <%= render(Primer::ProgressBarComponent.new(size: :small)) do |component| %>
    #     <% component.slot(:item, bg: :blue_4, percentage: 50) %>
    #   <% end %>
    #
    # @example Large
    #   <%= render(Primer::ProgressBarComponent.new(size: :large)) do |component| %>
    #     <% component.slot(:item, bg: :red_4, percentage: 75) %>
    #   <% end %>
    #
    # @example Multiple items
    #   <%= render(Primer::ProgressBarComponent.new) do |component| %>
    #     <% component.slot(:item, percentage: 10) %>
    #     <% component.slot(:item, bg: :blue_4, percentage: 20) %>
    #     <% component.slot(:item, bg: :red_4, percentage: 30) %>
    #   <% end %>
    #
    # @param size [Symbol] <%= one_of(Primer::ProgressBarComponent::SIZE_OPTIONS) %> Increases height.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(size: SIZE_DEFAULT, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "Progress",
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
      )
      @system_arguments[:tag] = :span
    end

    def render?
      items.any?
    end

    # :nodoc:
    class Item < Primer::Slot
      attr_reader :system_arguments

      # @param percentage [Integer] Percentage completion of item.
      # @param bg [Symbol] Color of item.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(percentage: 0, bg: :green, **system_arguments)
        @percentage = percentage
        @system_arguments = system_arguments

        @system_arguments[:tag] = :span
        @system_arguments[:bg] = bg
        @system_arguments[:style] =
          join_style_arguments(@system_arguments[:style], "width: #{@percentage}%;")
        @system_arguments[:classes] = class_names("Progress-item", @system_arguments[:classes])
      end
    end
  end
end
