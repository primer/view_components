# frozen_string_literal: true

module Primer
  # Component for rendering the status of an item.
  class StateComponent < Primer::Component
    COLOR_DEFAULT = :default
    COLOR_MAPPINGS = {
      COLOR_DEFAULT => "",
      :green => "State--green",
      :red => "State--red",
      :purple => "State--purple"
    }.freeze
    COLOR_OPTIONS = COLOR_MAPPINGS.keys

    SIZE_DEFAULT = :default
    SIZE_MAPPINGS = {
      SIZE_DEFAULT => "",
      :small => "State--small"
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    TAG_DEFAULT = :span
    TAG_OPTIONS = [TAG_DEFAULT, :div, :a].freeze

    # @example 35|Default
    #   <%= render(Primer::StateComponent.new(title: "title")) { "State" } %>
    #
    # @example 35|Colors
    #   <%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
    #   <%= render(Primer::StateComponent.new(title: "title", color: :green)) { "Green" } %>
    #   <%= render(Primer::StateComponent.new(title: "title", color: :red)) { "Red" } %>
    #   <%= render(Primer::StateComponent.new(title: "title", color: :purple)) { "Purple" } %>
    #
    # @example 35|Sizes
    #   <%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
    #   <%= render(Primer::StateComponent.new(title: "title", size: :small)) { "Small" } %>
    #
    # @param title [String] `title` HTML attribute.
    # @param color [Symbol] Background color. <%= one_of(Primer::StateComponent::COLOR_OPTIONS) %>
    # @param tag [Symbol] HTML tag for element. <%= one_of(Primer::StateComponent::TAG_OPTIONS) %>
    # @param size [Symbol] <%= one_of(Primer::StateComponent::SIZE_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      title:,
      color: COLOR_DEFAULT,
      tag: TAG_DEFAULT,
      size: SIZE_DEFAULT,
      **system_arguments
    )
      @system_arguments = system_arguments
      @system_arguments[:title] = title
      @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "State",
        COLOR_MAPPINGS[fetch_or_fallback(COLOR_OPTIONS, color, COLOR_DEFAULT)],
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
