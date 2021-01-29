# frozen_string_literal: true

module Primer
  # The Tooltip component is a wrapper component that will apply a tooltip to the provided content.
  class TooltipComponent < Primer::Component
    DIRECTION_DEFAULT = :n
    ALIGNMENT_DEFAULT = :right_1
    MULTILINE_DEFAULT = false
    DELAY_DEFAULT = false

    DIRECTION_OPTIONS = [DIRECTION_DEFAULT] + [
      :nw,
      :ne,
      :w,
      :e,
      :sw,
      :s,
      :se,
    ]

    ALIGNMENT_OPTIONS = [ALIGNMENT_DEFAULT] + [
      :left_1,
      :right_2,
      :left_2,
      :right_1,
      :left_1,
      :right_2,
      :left_2,
    ]

    # @example 50|Default
    #   <%= render(Primer::TooltipComponent.new(label: "Even bolder")) { "Bold Text" } %>
    #
    # @example 50|With a direction
    #   <%= render(Primer::TooltipComponent.new(label: "Even bolder", direction: :nw)) { "Bold Text" } %>
    #
    # @example 50|With an alignment
    #   <%= render(Primer::TooltipComponent.new(label: "Even bolder", alignment: :right_1)) { "Bold Text" } %>
    #
    # @example 50|Without a delay
    #   <%= render(Primer::TooltipComponent.new(label: "Even bolder", delay: false)) { "Bold Text" } %>
    #
    # @param label [String] the text to appear in the tooltip
    # @param direction [String] Direction of the tooltip. <%= one_of(Primer::TooltipComponent::DIRECTION_OPTIONS) %>
    # @param align [String] Align tooltips to the left or right of an element, combined with a `direction` to specify north or south. <%= one_of(Primer::TooltipComponent::ALIGNMENT_OPTIONS) %>
    # @param multiline [Boolean] Use this when you have long content
    # @param no_delay [Boolean] By default the tooltips have a slight delay before appearing. Set true to override this
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      label:,
      direction: DIRECTION_DEFAULT,
      align: ALIGNMENT_DEFAULT,
      multiline: ALIGNMENT_DEFAULT,
      no_delay: DELAY_DEFAULT,
      **system_arguments
    )
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :span
      @system_arguments[:aria] = { label: label }

      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "tooltipped",
        "tooltipped-#{fetch_or_fallback(DIRECTION_OPTIONS, direction, DIRECTION_DEFAULT)}" => direction.present?,
        "tooltipped-align-#{fetch_or_fallback(ALIGNMENT_OPTIONS, align, ALIGNMENT_DEFAULT).to_s.gsub("_", "-")}" => align.present?,
        "tooltipped-no-delay" => fetch_or_fallback_boolean(no_delay, DELAY_DEFAULT),
        "tooltipped-multiline" => fetch_or_fallback_boolean(multiline, MULTILINE_DEFAULT),
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
