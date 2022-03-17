# frozen_string_literal: true

module Primer
  # Use `IconButton` to render Icon-only buttons without the default button styles.
  #
  # @accessibility
  #   `IconButton` requires an `aria-label`, which will provide assistive technologies with an accessible label.
  #   The `aria-label` should describe the action to be invoked rather than the icon itself. For instance,
  #   if your `IconButton` renders a magnifying glass icon and invokes a search action, the `aria-label` should be
  #   `"Search"` instead of `"Magnifying glass"`.
  #   [Learn more about best functional image practices (WAI Images)](https://www.w3.org/WAI/tutorials/images/functional)
  class IconButton < Primer::Component
    status :beta

    DEFAULT_SCHEME = :default
    SCHEME_MAPPINGS = {
      DEFAULT_SCHEME => "",
      :danger => "btn-octicon-danger"
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

    # `Tooltip` that appears on mouse hover or keyboard focus over the button. Use tooltips sparingly and as a last resort.
    # **Important:** This tooltip defaults to `type: :label`. In a few scenarios, `type: :description` may be more appropriate.
    # Consult the <%= link_to_component(Primer::Alpha::Tooltip) %> documentation for more information.
    #
    # @param type [Symbol] (:label) <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>
    # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::Alpha::Tooltip) %>.
    renders_one :tooltip, lambda { |**system_arguments|
      raise ArgumentError, "IconButtons with a tooltip must have a unique `id` set on the `IconButton`." if @id.blank? && !Rails.env.production?

      @system_arguments = system_arguments

      @system_arguments[:for_id] = @id
      @system_arguments[:type] ||= :label

      Primer::Alpha::Tooltip.new(**@system_arguments)
    }

    # @example Default
    #
    #   <%= render(Primer::IconButton.new(icon: :search, "aria-label": "Search")) %>
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
    # @example With tooltip
    #   @description
    #     Use tooltips sparingly and as a last resort. Consult the <%= link_to_component(Primer::Alpha::Tooltip) %> documentation for more information.
    #   @code
    #     <%= render(Primer::IconButton.new(icon: :pencil, box: true, "aria-label": "Edit", id: "button-with-tooltip")) do |component| %>
    #       <% component.tooltip(text: "Tooltip text") %>
    #     <% end %>
    #
    # @param scheme [Symbol] <%= one_of(Primer::IconButton::SCHEME_OPTIONS) %>
    # @param icon [String] Name of <%= link_to_octicons %> to use.
    # @param tag [Symbol] <%= one_of(Primer::BaseButton::TAG_OPTIONS) %>
    # @param type [Symbol] <%= one_of(Primer::BaseButton::TYPE_OPTIONS) %>
    # @param box [Boolean] Whether the button is in a <%= link_to_component(Primer::BorderBoxComponent) %>. If `true`, the button will have the `Box-btn-octicon` class.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(icon:, scheme: DEFAULT_SCHEME, box: false, **system_arguments)
      @icon = icon

      @system_arguments = system_arguments

      @id = @system_arguments[:id]

      @system_arguments[:classes] = class_names(
        "btn-octicon",
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)],
        system_arguments[:classes],
        "Box-btn-octicon" => box
      )

      validate_aria_label
    end
  end
end
