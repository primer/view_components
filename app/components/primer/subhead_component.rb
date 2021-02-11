# frozen_string_literal: true

module Primer
  # Use the Subhead component for page headings.
  class SubheadComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :heading, class_name: "Heading"
    with_slot :actions, class_name: "Actions"
    with_slot :description, class_name: "Description"

    # @example auto|Default
    #   <%= render(Primer::SubheadComponent.new) do |component| %>
    #     <% component.slot(:heading) do %>
    #       My Heading
    #     <% end %>
    #     <% component.slot(:description) do %>
    #       My Description
    #     <% end %>
    #   <% end %>
    #
    # @example auto|Without border
    #   <%= render(Primer::SubheadComponent.new(hide_border: true)) do |component| %>
    #     <% component.slot(:heading) do %>
    #       My Heading
    #     <% end %>
    #     <% component.slot(:description) do %>
    #       My Description
    #     <% end %>
    #   <% end %>
    #
    # @example auto|With actions
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

    # :nodoc
    class Heading < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :system_arguments

      # @param danger [Boolean] Whether to style the heading as dangerous.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(danger: false, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] ||= :div
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "Subhead-heading",
          "Subhead-heading--danger": danger
        )
      end
    end

    # :nodoc
    class Actions < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :system_arguments

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(@system_arguments[:classes], "Subhead-actions")
      end
    end

    # :nodoc
    class Description < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :system_arguments

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(@system_arguments[:classes], "Subhead-description")
      end
    end
  end
end
