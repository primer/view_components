# frozen_string_literal: true

module Primer
  # Use ProgressBar to visualize task completion.
  class ProgressBarComponent < Primer::Component
    include ViewComponent::SlotableV2

    # Use the Item slot to add an item to the progress bas
    #
    # @param percentage [Integer] The percent complete
    # @param bg [Symbol] The background color
    # @param kwargs [Hash] The same arguments as <%= link_to_system_arguments_docs %>.
    renders_many :items, lambda { |percentage: 0, bg: :green, **system_arguments|
      percentage = percentage
      system_arguments = system_arguments

      system_arguments[:tag] = :span
      system_arguments[:bg] = bg
      system_arguments[:style] = join_style_arguments(system_arguments[:style], "width: #{percentage}%;")
      system_arguments[:classes] = class_names("Progress-item", system_arguments[:classes])

      Primer::BaseComponent.new(**system_arguments)
    }

    SIZE_DEFAULT = :default

    SIZE_MAPPINGS = {
      SIZE_DEFAULT => "",
      :small => "Progress--small",
      :large => "Progress--large"
    }.freeze

    SIZE_OPTIONS = SIZE_MAPPINGS.keys
    # @example auto|Default
    #   <%= render(Primer::ProgressBarComponent.new) do |component| %>
    #     <% component.item(percentage: 25) %>
    #   <% end %>
    #
    # @example auto|Small
    #   <%= render(Primer::ProgressBarComponent.new(size: :small)) do |component| %>
    #     <% component.item(bg: :blue_4, percentage: 50) %>
    #   <% end %>
    #
    # @example auto|Large
    #   <%= render(Primer::ProgressBarComponent.new(size: :large)) do |component| %>
    #     <% component.item(bg: :red_4, percentage: 75) %>
    #   <% end %>
    #
    # @example auto|Multiple items
    #   <%= render(Primer::ProgressBarComponent.new) do |component| %>
    #     <% component.item(percentage: 10) %>
    #     <% component.item(bg: :blue_4, percentage: 20) %>
    #     <% component.item(bg: :red_4, percentage: 30) %>
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
  end
end
