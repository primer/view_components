# frozen_string_literal: true

module Primer
  # Use `FlexItem` to specify the ability of a flex item to alter its
  # dimensions to fill available space.
  #
  # @deprecated
  #   Use <%= link_to_component(Primer::Box) %> instead.
  #
  #   **Before**:
  #
  #   ```erb
  #   <%%= render Primer::FlexItemComponent.new(flex_auto: :auto) %>
  #   ```
  #
  #   **After**:
  #
  #   ```erb
  #   <%%= render Primer::Box.new(flex: :auto) %>
  #   ```
  class FlexItemComponent < Primer::Component
    status :deprecated

    FLEX_AUTO_DEFAULT = false
    FLEX_AUTO_ALLOWED_VALUES = [FLEX_AUTO_DEFAULT, true].freeze

    # @example Default
    #   <%= render(Primer::FlexComponent.new) do %>
    #     <%= render(Primer::FlexItemComponent.new) do %>
    #       Item 1
    #     <% end %>
    #
    #     <%= render(Primer::FlexItemComponent.new(flex_auto: true)) do %>
    #       Item 2
    #     <% end %>
    #   <% end %>
    #
    # @param flex_auto [Boolean] Fills available space and auto-sizes based on the content. Defaults to <%= Primer::FlexItemComponent::FLEX_AUTO_DEFAULT %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(flex_auto: FLEX_AUTO_DEFAULT, **system_arguments)
      deprecated_component_warning(new_class: Primer::Box, version: "0.0.40")

      @system_arguments = system_arguments
      @system_arguments[:classes] =
        class_names(
          @system_arguments[:classes],
          "flex-auto" => fetch_or_fallback(FLEX_AUTO_ALLOWED_VALUES, flex_auto, FLEX_AUTO_DEFAULT)
        )
    end

    def call
      render(Primer::Box.new(**@system_arguments)) { content }
    end
  end
end
