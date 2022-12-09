# frozen_string_literal: true

module Primer
  # Use `State` for rendering the status of an item.
  class StateComponent < Primer::Component
    warn_on_deprecated_slot_setter
    status :beta

    SCHEME_DEFAULT = :default
    NEW_SCHEME_MAPPINGS = {
      open: "State--open",
      closed: "State--closed",
      merged: "State--merged"
    }.freeze

    DEPRECATED_SCHEME_MAPPINGS = {
      SCHEME_DEFAULT => "",
      :green => "State--open",
      :red => "State--closed",
      :purple => "State--merged"
    }.freeze
    SCHEME_MAPPINGS = NEW_SCHEME_MAPPINGS.merge(DEPRECATED_SCHEME_MAPPINGS)
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

    SIZE_DEFAULT = :default
    SIZE_MAPPINGS = {
      SIZE_DEFAULT => "",
      :small => "State--small"
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    TAG_DEFAULT = :span
    TAG_OPTIONS = [TAG_DEFAULT, :div].freeze

    # @example Default
    #   <%= render(Primer::StateComponent.new(title: "title")) { "State" } %>
    #
    # @example Schemes
    #   <%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
    #   <%= render(Primer::StateComponent.new(title: "title", scheme: :open)) { "Open" } %>
    #   <%= render(Primer::StateComponent.new(title: "title", scheme: :closed)) { "Closed" } %>
    #   <%= render(Primer::StateComponent.new(title: "title", scheme: :merged)) { "Merged" } %>
    #
    # @example Sizes
    #   <%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
    #   <%= render(Primer::StateComponent.new(title: "title", size: :small)) { "Small" } %>
    #
    # @param title [String] `title` HTML attribute.
    # @param scheme [Symbol] Background color. <%= one_of(Primer::StateComponent::SCHEME_OPTIONS) %>
    # @param tag [Symbol] HTML tag for element. <%= one_of(Primer::StateComponent::TAG_OPTIONS) %>
    # @param size [Symbol] <%= one_of(Primer::StateComponent::SIZE_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      title:,
      scheme: SCHEME_DEFAULT,
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
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, SCHEME_DEFAULT)],
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
