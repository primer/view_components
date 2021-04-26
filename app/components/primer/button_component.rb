# frozen_string_literal: true

module Primer
  # Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.
  class ButtonComponent < Primer::Component
    status :beta

    DEFAULT_SCHEME = :default
    LINK_SCHEME = :link
    SCHEME_MAPPINGS = {
      DEFAULT_SCHEME => "",
      :primary => "btn-primary",
      :danger => "btn-danger",
      :outline => "btn-outline",
      :invisible => "btn-invisible",
      LINK_SCHEME => "btn-link"
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

    DEFAULT_VARIANT = :medium
    VARIANT_MAPPINGS = {
      :small => "btn-sm",
      DEFAULT_VARIANT => "",
      :large => "btn-large"
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys

    DEFAULT_ICON_ALIGNMENT = :left
    ICON_ALIGNMENT_OPTIONS = [DEFAULT_ICON_ALIGNMENT, :right].freeze

    # Icon to be rendered in the button.
    #
    # @param align [Symbol] <%= one_of(Primer::ButtonComponent::ICON_ALIGN_OPTIONS) %>
    # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
    renders_one :icon, lambda { |align: DEFAULT_ICON_ALIGNMENT, **system_arguments|
      @icon_align = fetch_or_fallback(ICON_ALIGNMENT_OPTIONS, align, DEFAULT_ICON_ALIGNMENT)

      Primer::OcticonComponent.new(**system_arguments)
    }

    # Counter to be rendered in the button.
    #
    # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::CounterComponent) %>.
    renders_one :counter, Primer::CounterComponent

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
    # @example With icons
    #   <%= render(Primer::ButtonComponent.new) do |c| %>
    #     <% c.icon(icon: :star) %>
    #     Button
    #   <% end %>
    #   <%= render(Primer::ButtonComponent.new) do |c| %>
    #     <% c.icon(icon: :star, align: :right) %>
    #     Button
    #   <% end %>
    #
    # @example With counter
    #   <%= render(Primer::ButtonComponent.new) do |c| %>
    #     <% c.counter(count: 15) %>
    #     Button
    #   <% end %>
    #
    # @example With icons and counter
    #   <%= render(Primer::ButtonComponent.new) do |c| %>
    #     <% c.icon(icon: :star) %>
    #     <% c.counter(count: 15) %>
    #     Button
    #   <% end %>
    #   <%= render(Primer::ButtonComponent.new) do |c| %>
    #     <% c.icon(icon: :star, align: :right) %>
    #     <% c.counter(count: 15) %>
    #     Button
    #   <% end %>
    #
    # @param scheme [Symbol] <%= one_of(Primer::ButtonComponent::SCHEME_OPTIONS) %>
    # @param variant [Symbol] <%= one_of(Primer::ButtonComponent::VARIANT_OPTIONS) %>
    # @param tag [Symbol] <%= one_of(Primer::BaseButton::TAG_OPTIONS) %>
    # @param type [Symbol] <%= one_of(Primer::BaseButton::TYPE_OPTIONS) %>
    # @param group_item [Boolean] Whether button is part of a ButtonGroup.
    # @param block [Boolean] Whether button is full-width with `display: block`.
    def initialize(
      scheme: DEFAULT_SCHEME,
      variant: DEFAULT_VARIANT,
      group_item: false,
      block: false,
      **system_arguments
    )
      @scheme = scheme
      @system_arguments = system_arguments
      @system_arguments[:classes] = class_names(
        system_arguments[:classes],
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)],
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant, DEFAULT_VARIANT)],
        "btn" => !link?,
        "btn-block" => block,
        "BtnGroup-item" => group_item
      )
    end

    private

    def link?
      @scheme == LINK_SCHEME
    end
  end
end
