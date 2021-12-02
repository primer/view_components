# frozen_string_literal: true

module Primer
  # Use `Button` for actions (e.g. in forms). Use links for destinations, or moving from one page to another.
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
      DEFAULT_VARIANT => ""
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys

    # Leading visuals appear to the left of the button text.
    #
    # Use:
    #
    # - `leading_visual_icon` for a <%= link_to_component(Primer::OcticonComponent) %>.
    #
    # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
    renders_one :leading_visual, types: {
      icon: lambda { |**system_arguments|
        system_arguments[:mr] = 2

        Primer::OcticonComponent.new(**system_arguments)
      }
    }
    alias icon leading_visual_icon # remove alias when all buttons are migrated to new slot names

    # Trailing visuals appear to the right of the button text.
    #
    # Use:
    #
    # - `trailing_visual_counter` for a <%= link_to_component(Primer::CounterComponent) %>.
    #
    # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::CounterComponent) %>.
    renders_one :trailing_visual, types: {
      counter: lambda { |**system_arguments|
        system_arguments[:ml] = 2

        Primer::CounterComponent.new(**system_arguments)
      }
    }
    alias counter trailing_visual_counter # remove alias when all buttons are migrated to new slot names

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
    #
    # @example Block
    #   <%= render(Primer::ButtonComponent.new(block: :true)) { "Block" } %>
    #   <%= render(Primer::ButtonComponent.new(block: :true, scheme: :primary)) { "Primary block" } %>
    #
    # @example With leading visual
    #   <%= render(Primer::ButtonComponent.new) do |c| %>
    #     <% c.leading_visual_icon(icon: :star) %>
    #     Button
    #   <% end %>
    #
    # @example With trailing visual
    #   <%= render(Primer::ButtonComponent.new) do |c| %>
    #     <% c.trailing_visual_counter(count: 15) %>
    #     Button
    #   <% end %>
    #
    # @example With leading and trailing visuals
    #   <%= render(Primer::ButtonComponent.new) do |c| %>
    #     <% c.leading_visual_icon(icon: :star) %>
    #     <% c.trailing_visual_counter(count: 15) %>
    #     Button
    #   <% end %>
    #
    # @example With dropdown caret
    #   <%= render(Primer::ButtonComponent.new(dropdown: true)) do %>
    #     Button
    #   <% end %>
    #
    # @param scheme [Symbol] <%= one_of(Primer::ButtonComponent::SCHEME_OPTIONS) %>
    # @param variant [Symbol] <%= one_of(Primer::ButtonComponent::VARIANT_OPTIONS) %>
    # @param tag [Symbol] (Primer::BaseButton::DEFAULT_TAG) <%= one_of(Primer::BaseButton::TAG_OPTIONS) %>
    # @param type [Symbol] (Primer::BaseButton::DEFAULT_TYPE) <%= one_of(Primer::BaseButton::TYPE_OPTIONS) %>
    # @param group_item [Boolean] Whether button is part of a ButtonGroup.
    # @param block [Boolean] Whether button is full-width with `display: block`.
    # @param dropdown [Boolean] Whether or not to render a dropdown caret.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      scheme: DEFAULT_SCHEME,
      variant: DEFAULT_VARIANT,
      group_item: false,
      block: false,
      dropdown: false,
      **system_arguments
    )
      @scheme = scheme
      @dropdown = dropdown

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

    def trimmed_content
      return if content.blank?

      trimmed_content = content.strip

      return trimmed_content unless content.html_safe?

      # strip unsets `html_safe`, so we have to set it back again to guarantee that HTML blocks won't break
      trimmed_content.html_safe # rubocop:disable Rails/OutputSafety
    end
  end
end
