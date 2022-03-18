# frozen_string_literal: true

module Primer
  # Use `IconButton` to render Icon-only buttons without the default button styles.
  #
  # @accessibility
  #   `IconButton` requires an `aria-label`, which will provide assistive technologies with an accessible label.
  #   The `aria-label` should describe the action to be invoked rather than the icon itself. For instance,
  #   if your `IconButton` renders a magnifying glass icon and invokes a search action, the `aria-label` should be
  #   `"Search"` instead of `"Magnifying glass"`.
  #   Internally the `aria-label` will be used for the `Tooltip` text. The `button` element is associated via `aria-labelledby`
  #   to the `Tooltip` so it will serve as the `aria-label` for the `button`.
  #   [Learn more about best functional image practices (WAI Images)](https://www.w3.org/WAI/tutorials/images/functional)
  class IconButton < Primer::Component
    status :beta

    DEFAULT_SCHEME = :default
    SCHEME_MAPPINGS = {
      DEFAULT_SCHEME => "",
      :danger => "btn-octicon-danger"
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

    # @example Default
    #
    #   <%= render(Primer::IconButton.new(icon: :search, "aria-label": "Search", id: "search-button")) %>
    #
    # @example Schemes
    #
    #   <%= render(Primer::IconButton.new(icon: :search, "aria-label": "Search")) %>
    #   <%= render(Primer::IconButton.new(icon: :trash, "aria-label": "Delete", scheme: :danger)) %>
    #
    # @example In a BorderBox
    #
    #   <%= render(Primer::BorderBoxComponent.new) do |component| %>
    #     <% component.body do %>
    #       <%= render(Primer::Beta::Text.new(pr: 2)) { "Body" } %>
    #       <%= render(Primer::IconButton.new(icon: :pencil, box: true, "aria-label": "Edit")) %>
    #     <% end %>
    #   <% end %>
    #
    # @example Custom tooltip direction
    #
    #   <%= render(Primer::IconButton.new(icon: :search, "aria-label": "Search", tooltip_direction: :e)) %>
    #
    # @param scheme [Symbol] <%= one_of(Primer::IconButton::SCHEME_OPTIONS) %>
    # @param icon [String] Name of <%= link_to_octicons %> to use.
    # @param tag [Symbol] <%= one_of(Primer::BaseButton::TAG_OPTIONS) %>
    # @param type [Symbol] <%= one_of(Primer::BaseButton::TYPE_OPTIONS) %>
    # @param box [Boolean] Whether the button is in a <%= link_to_component(Primer::BorderBoxComponent) %>. If `true`, the button will have the `Box-btn-octicon` class.
    # @param tooltip_direction [Symbol] (Primer::Alpha::Tooltip::DIRECTION_DEFAULT) <%= one_of(Primer::Alpha::Tooltip::DIRECTION_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(icon:, scheme: DEFAULT_SCHEME, box: false, **system_arguments)
      @icon = icon

      @system_arguments = system_arguments

      @system_arguments[:id] ||= "icon-button-#{SecureRandom.hex(4)}"
      @system_arguments[:tooltip_direction] ||= Primer::Alpha::Tooltip::DIRECTION_DEFAULT

      @system_arguments[:classes] = class_names(
        "btn-octicon",
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)],
        system_arguments[:classes],
        "Box-btn-octicon" => box
      )

      validate_aria_label

      # The `aria-label` is used as the tooltip text, which is the `aria-labelled-by` of the button, so we don't set it in the button.
      @aria_label = aria("label", @system_arguments)
      @system_arguments.delete(:"aria-label")
      @system_arguments[:aria].delete(:label) if @system_arguments.include?(:aria)
    end
  end
end
