# frozen_string_literal: true

module Primer
  # Use `IconButton` to render Icon-only buttons without the default button styles.
  #
  # `IconButton` will always render with a tooltip unless the tag is `:summary`.
  # @accessibility
  #   `IconButton` requires an `aria-label`, which will provide assistive technologies with an accessible label.
  #   The `aria-label` should describe the action to be invoked rather than the icon itself. For instance,
  #   if your `IconButton` renders a magnifying glass icon and invokes a search action, the `aria-label` should be
  #   `"Search"` instead of `"Magnifying glass"`.
  #   Either `aria-label` or `aria-description` will be used for the `Tooltip` text, depending on which one is present.
  #   [Learn more about best functional image practices (WAI Images)](https://www.w3.org/WAI/tutorials/images/functional)
  class IconButton < Primer::Component
    warn_on_deprecated_slot_setter
    status :deprecated

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
    #   <%= render(Primer::Beta::BorderBox.new) do |component| %>
    #     <% component.body do %>
    #       <%= render(Primer::Beta::Text.new(pr: 2)) { "Body" } %>
    #       <%= render(Primer::IconButton.new(icon: :pencil, box: true, "aria-label": "Edit")) %>
    #     <% end %>
    #   <% end %>
    #
    # @example With an `aria-description`
    #   @description
    #     If you need to have a longer description for the icon button, use both the `aria-label` and `aria-description`
    #     attributes. A label should be short and concise, while the description can be longer as it is intended to provide
    #     more context and information. See the accessibility section for more information.
    #   @code
    #     <%= render(Primer::IconButton.new(icon: :bold, "aria-label": "Bold", "aria-description": "Add bold text, Cmd+b")) %>
    #
    # @example Custom tooltip direction
    #
    #   <%= render(Primer::IconButton.new(icon: :search, "aria-label": "Search", tooltip_direction: :e)) %>
    #
    # @param scheme [Symbol] <%= one_of(Primer::IconButton::SCHEME_OPTIONS) %>
    # @param icon [String] Name of <%= link_to_octicons %> to use.
    # @param tag [Symbol] <%= one_of(Primer::Beta::BaseButton::TAG_OPTIONS) %>
    # @param type [Symbol] <%= one_of(Primer::Beta::BaseButton::TYPE_OPTIONS) %>
    # @param aria-label [String] String that can be read by assistive technology. A label should be short and concise. See the accessibility section for more information.
    # @param aria-description [String] String that can be read by assistive technology. A description can be longer as it is intended to provide more context and information. See the accessibility section for more information.
    # @param tooltip_direction [Symbol] (Primer::Alpha::Tooltip::DIRECTION_DEFAULT) <%= one_of(Primer::Alpha::Tooltip::DIRECTION_OPTIONS) %>
    # @param box [Boolean] Whether the button is in a <%= link_to_component(Primer::Beta::BorderBox) %>. If `true`, the button will have the `Box-btn-octicon` class.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(icon:, scheme: DEFAULT_SCHEME, box: false, tooltip_direction: Primer::Alpha::Tooltip::DIRECTION_DEFAULT, **system_arguments)
      @icon = icon

      @system_arguments = system_arguments

      @system_arguments[:id] ||= "icon-button-#{SecureRandom.hex(4)}"

      @system_arguments[:classes] = class_names(
        "btn-octicon",
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)],
        system_arguments[:classes],
        "Box-btn-octicon" => box
      )

      validate_aria_label

      @aria_label = aria("label", @system_arguments)
      @aria_description = aria("description", @system_arguments)

      @tooltip_arguments = {
        for_id: @system_arguments[:id],
        direction: tooltip_direction
      }

      # If we have both an `aria-label` and a `aria-description`, we create a `Tooltip` with the description type and keep the `aria-label` in the button.
      # Otherwise, the `aria-label` is used as the tooltip text, which is the `aria-labelled-by` of the button, so we don't set it in the button.
      if @aria_label.present? && @aria_description.present?
        @system_arguments.delete(:"aria-description")
        @system_arguments[:aria].delete(:description) if @system_arguments.include?(:aria)
        @tooltip_arguments[:text] = @aria_description
        @tooltip_arguments[:type] = :description
      else
        @system_arguments.delete(:"aria-label")
        @system_arguments[:aria].delete(:label) if @system_arguments.include?(:aria)
        @tooltip_arguments[:text] = @aria_label
        @tooltip_arguments[:type] = :label
      end
    end

    private

    def render_tooltip?
      @system_arguments[:tag] != :summary
    end
  end
end
