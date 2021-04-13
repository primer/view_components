# frozen_string_literal: true

module Primer
  # Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.
  class ButtonComponent < Primer::Component
    status :beta

    DEFAULT_SCHEME = :default
    SCHEME_MAPPINGS = {
      DEFAULT_SCHEME => "",
      :primary => "btn-primary",
      :danger => "btn-danger",
      :outline => "btn-outline",
      :invisible => "btn-invisible",
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

    # @example Schemes
    #   <%= render(Primer::ButtonComponent.new) { "Default" } %>
    #   <%= render(Primer::ButtonComponent.new(scheme: :primary)) { "Primary" } %>
    #   <%= render(Primer::ButtonComponent.new(scheme: :danger)) { "Danger" } %>
    #   <%= render(Primer::ButtonComponent.new(scheme: :outline)) { "Outline" } %>
    #   <%= render(Primer::ButtonComponent.new(scheme: :invisible)) { "Invisible" } %>
    #   <%= render(Primer::ButtonComponent.new(scheme: :link)) { "Link" } %>
    #
    # @example Variants
    #   <%= render(Primer::ButtonComponent.new(variant: :small)) { "Small" } %>
    #   <%= render(Primer::ButtonComponent.new(variant: :medium)) { "Medium" } %>
    #   <%= render(Primer::ButtonComponent.new(variant: :large)) { "Large" } %>
    #
    # @example Block
    #   <%= render(Primer::ButtonComponent.new(block: :true)) { "Block" } %>
    #   <%= render(Primer::ButtonComponent.new(block: :true, scheme: :primary)) { "Primary block" } %>
    #
    # @param scheme [Symbol] <%= one_of(Primer::ButtonComponent::SCHEME_OPTIONS) %>
    # @param variant [Symbol] <%= one_of(Primer::Button::Base::VARIANT_OPTIONS) %>
    # @param tag [Symbol] <%= one_of(Primer::Button::Base::TAG_OPTIONS) %>
    # @param type [Symbol] <%= one_of(Primer::Button::Base::TYPE_OPTIONS) %>
    # @param group_item [Boolean] Whether button is part of a ButtonGroup.
    # @param block [Boolean] Whether button is full-width with `display: block`.
    def initialize(
      scheme: DEFAULT_SCHEME,
      **system_arguments
    )
      @system_arguments = system_arguments
      @system_arguments[:classes] = class_names(
        "btn",
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)],
        system_arguments[:classes],
      )
    end

    def call
      render(Primer::Button::Base.new(**@system_arguments)) { content }
    end
  end
end
