# frozen_string_literal: true

module Primer
  # Use the Subhead component for page headings.
  class SubheadComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :heading, class_name: "Heading"
    with_slot :actions, class_name: "Actions"
    with_slot :description, class_name: "Description"

    # @example 95|Default
    #   <%= render(Primer::SubheadComponent.new) do |component| %>
    #     <% component.slot(:heading) do %>
    #       My Heading
    #     <% end %>
    #     <% component.slot(:description) do %>
    #       My Description
    #     <% end %>
    #   <% end %>
    #
    # @example 95|Without border
    #   <%= render(Primer::SubheadComponent.new(hide_border: true)) do |component| %>
    #     <% component.slot(:heading) do %>
    #       My Heading
    #     <% end %>
    #     <% component.slot(:description) do %>
    #       My Description
    #     <% end %>
    #   <% end %>
    #
    # @example 95|With actions
    #   <%= render(Primer::SubheadComponent.new) do |component| %>
    #     <% component.slot(:heading) do %>
    #       My Heading
    #     <% end %>
    #     <% component.slot(:description) do %>
    #       My Description
    #     <% end %>
    #     <% component.slot(:actions) do %>
    #       <%= render(
    #         Primer::ButtonComponent.new(
    #           tag: :a, href: "http://www.google.com", button_type: :danger
    #         )
    #       ) { "Action" } %>
    #     <% end %>
    #   <% end %>
    #
    # @param spacious [Boolean] Whether to add spacing to the Subhead.
    # @param hide_border [Boolean] Whether to hide the border under the heading.
    # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
    def initialize(spacious: false, hide_border: false, **kwargs)
      @kwargs = kwargs

      @kwargs[:tag] = :div
      @kwargs[:classes] =
        class_names(
          @kwargs[:classes],
          "Subhead",
          "Subhead--spacious": spacious,
          "border-bottom-0": hide_border
        )
      @kwargs[:mb] ||= hide_border ? 0 : nil
    end

    def render?
      heading.present?
    end

    class Heading < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :kwargs

      # @param danger [Boolean] Whether to style the heading as dangerous.
      # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
      def initialize(danger: false, **kwargs)
        @kwargs = kwargs
        @kwargs[:tag] ||= :div
        @kwargs[:classes] = class_names(
          @kwargs[:classes],
          "Subhead-heading",
          "Subhead-heading--danger": danger
        )
      end
    end

    class Actions < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :kwargs

      # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(@kwargs[:classes], "Subhead-actions")
      end
    end

    class Description < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :kwargs

      # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(@kwargs[:classes], "Subhead-description")
      end
    end
  end
end
