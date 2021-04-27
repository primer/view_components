# frozen_string_literal: true

module Primer
  # Use `Subhead` for page headings.
  class SubheadComponent < Primer::Component
    status :beta

    # The heading
    #
    # @param danger [Boolean] Whether to style the heading as dangerous.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :heading, lambda { |danger: false, **system_arguments|
      system_arguments[:tag] ||= :div
      system_arguments[:classes] = class_names(
        system_arguments[:classes],
        "Subhead-heading",
        "Subhead-heading--danger": danger
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    # Actions
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :actions, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(system_arguments[:classes], "Subhead-actions")

      Primer::BaseComponent.new(**system_arguments)
    }

    # The description
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :description, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(system_arguments[:classes], "Subhead-description")

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #   <%= render(Primer::SubheadComponent.new) do |component| %>
    #     <% component.heading do %>
    #       My Heading
    #     <% end %>
    #     <% component.description do %>
    #       My Description
    #     <% end %>
    #   <% end %>
    #
    # @example Without border
    #   <%= render(Primer::SubheadComponent.new(hide_border: true)) do |component| %>
    #     <% component.heading do %>
    #       My Heading
    #     <% end %>
    #     <% component.description do %>
    #       My Description
    #     <% end %>
    #   <% end %>
    #
    # @example With actions
    #   <%= render(Primer::SubheadComponent.new) do |component| %>
    #     <% component.heading do %>
    #       My Heading
    #     <% end %>
    #     <% component.description do %>
    #       My Description
    #     <% end %>
    #     <% component.actions do %>
    #       <%= render(
    #         Primer::ButtonComponent.new(
    #           tag: :a, href: "http://www.google.com", scheme: :danger
    #         )
    #       ) { "Action" } %>
    #     <% end %>
    #   <% end %>
    #
    # @param spacious [Boolean] Whether to add spacing to the Subhead.
    # @param hide_border [Boolean] Whether to hide the border under the heading.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(spacious: false, hide_border: false, **system_arguments)
      @system_arguments = system_arguments

      @system_arguments[:tag] = :div
      @system_arguments[:classes] =
        class_names(
          @system_arguments[:classes],
          "Subhead hx_Subhead--responsive",
          "Subhead--spacious": spacious,
          "border-bottom-0": hide_border
        )
      @system_arguments[:mb] ||= hide_border ? 0 : nil
    end

    def render?
      heading.present?
    end
  end
end
