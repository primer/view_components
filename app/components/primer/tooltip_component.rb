# frozen_string_literal: true

module Primer
  # The Tooltip component is a wrapper component that will apply a tooltip to the provided content.
  class TooltipComponent < Primer::Component
    DIRECTION_DEFAULT = :n
    ALIGN_DEFAULT = :default
    MULTILINE_DEFAULT = false
    DELAY_DEFAULT = false

    ALIGN_MAPPING = {
      ALIGN_DEFAULT => "",
      :left_1 => "tooltipped-align-left-1",
      :right_1 => "tooltipped-align-right-1",
      :left_2 => "tooltipped-align-left-2",
      :right_2 => "tooltipped-align-right-2",
    }

    DIRECTION_OPTIONS = [DIRECTION_DEFAULT] + [
      :nw,
      :ne,
      :w,
      :e,
      :sw,
      :s,
      :se,
    ]

    # @example 100|Default
    #   <div class="pt-5">
    #     <%= render(Primer::TooltipComponent.new(label: "Even bolder")) { "Default Bold Text" } %>
    #   </div>
    #
    # @example 100|Wrapping another component
    #   <div class="pt-5">
    #     <%= render(Primer::TooltipComponent.new(label: "Even bolder")) do %>
    #       <%= render(Primer::ButtonComponent.new) { "Bold Button" } %>
    #     <% end %>
    #   </div>
    #
    # @example 100|With a direction
    #   <div class="pt-5">
    #     <%= render(Primer::TooltipComponent.new(label: "Even bolder", direction: :s)) { "Bold Text With a Direction" } %>
    #   </div>
    #
    # @example 100|With an alignment
    #   <div class="pt-5">
    #     <%= render(Primer::TooltipComponent.new(label: "Even bolder", direction: :s, alignment: :right_1)) { "Bold Text With an Alignment" } %>
    #   </div>
    #
    # @example 100|Without a delay
    #   <div class="pt-5">
    #     <%= render(Primer::TooltipComponent.new(label: "Even bolder", direction: :s, no_delay: true)) { "Bold Text without a delay" } %>
    #   </div>
    #
    # @param label [String] the text to appear in the tooltip
    # @param direction [String] Direction of the tooltip. <%= one_of(Primer::TooltipComponent::DIRECTION_OPTIONS) %>
    # @param align [String] Align tooltips to the left or right of an element, combined with a `direction` to specify north or south. <%= one_of(Primer::TooltipComponent::ALIGN_MAPPING.keys - [Primer::TooltipComponent::ALIGN_DEFAULT]) %>
    # @param multiline [Boolean] Use this when you have long content
    # @param no_delay [Boolean] By default the tooltips have a slight delay before appearing. Set true to override this
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      label:,
      direction: DIRECTION_DEFAULT,
      align: ALIGN_DEFAULT,
      multiline: MULTILINE_DEFAULT,
      no_delay: DELAY_DEFAULT,
      **system_arguments
    )
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :span
      @system_arguments[:aria] = { label: label }

      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "tooltipped",
        "tooltipped-#{fetch_or_fallback(DIRECTION_OPTIONS, direction, DIRECTION_DEFAULT)}",
        ALIGN_MAPPING[fetch_or_fallback(ALIGN_MAPPING.keys, align, :default)],
        "tooltipped-no-delay" => fetch_or_fallback_boolean(no_delay, DELAY_DEFAULT),
        "tooltipped-multiline" => fetch_or_fallback_boolean(multiline, MULTILINE_DEFAULT),
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
