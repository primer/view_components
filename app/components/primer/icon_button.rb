# frozen_string_literal: true

module Primer
  # Use `IconButton` to render Icon-only buttons without the default button styles.
  #
  # @accessibility
  #   `IconButton` requires an `aria-label`, which will provide assistive technologies with an accessible label.
  class IconButton < Primer::Component
    DEFAULT_SCHEME = :default
    SCHEME_MAPPINGS = {
      DEFAULT_SCHEME => "",
      :danger => "btn-octicon-danger"
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys
    # @example Default
    #
    #   <%= render(Primer::IconButton.new(icon: :search, "aria-label": "Search")) %>
    #
    # @example Schemes
    #
    #   <%= render(Primer::IconButton.new(icon: :search, "aria-label": "Search")) %>
    #   <%= render(Primer::IconButton.new(icon: :trash, "aria-label": "Delete", scheme: :danger)) %>
    #
    # @param scheme [Symbol] <%= one_of(Primer::IconButton::SCHEME_OPTIONS) %>
    # @param icon [String] Name of <%= link_to_octicons %> to use.
    # @param tag [Symbol] <%= one_of(Primer::BaseButton::TAG_OPTIONS) %>
    # @param type [Symbol] <%= one_of(Primer::BaseButton::TYPE_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(scheme: DEFAULT_SCHEME, icon:, **system_arguments)
      @icon = icon

      @system_arguments = system_arguments
      @system_arguments[:classes] = class_names(
        "btn-octicon",
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)],
        system_arguments[:classes]
      )

      validate_aria_label
    end

    def call
      render(Primer::BaseButton.new(**@system_arguments)) do
        render(Primer::OcticonComponent.new(icon: @icon))
      end
    end
  end
end
