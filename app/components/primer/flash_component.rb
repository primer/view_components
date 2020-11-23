# frozen_string_literal: true

module Primer
  # Use the Flash component to inform users of successful or pending actions.
  class FlashComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :actions, class_name: "Actions"

    DEFAULT_VARIANT = :default
    VARIANT_MAPPINGS = {
      DEFAULT_VARIANT => "",
      :warning => "flash-warn",
      :danger => "flash-error",
      :success => "flash-success"
    }.freeze
    # @example 280|Variants
    #   <%= render(Primer::FlashComponent.new) { "This is a flash message!" } %>
    #   <%= render(Primer::FlashComponent.new(variant: :warning)) { "This is a warning flash message!" } %>
    #   <%= render(Primer::FlashComponent.new(variant: :danger)) { "This is a danger flash message!" } %>
    #   <%= render(Primer::FlashComponent.new(variant: :success)) { "This is a success flash message!" } %>
    #
    # @example 80|Full width
    #   <%= render(Primer::FlashComponent.new(full: true)) { "This is a full width flash message!" } %>
    #
    # @example 80|Dismissible
    #   <%= render(Primer::FlashComponent.new(dismissible: true)) { "This is a dismissible flash message!" } %>
    #
    # @example 80|Icon
    #   <%= render(Primer::FlashComponent.new(icon: "people")) { "This is a flash message with an icon!" } %>
    #
    # @example 80|With actions
    #   <%= render(Primer::FlashComponent.new) do |component| %>
    #     This is a flash message with actions!
    #     <% component.slot(:actions) do %>
    #       <%= render(Primer::ButtonComponent.new(variant: :small)) { "Take action" } %>
    #     <% end %>
    #   <% end %>
    #
    # @param full [Boolean] Whether the component should take up the full width of the screen.
    # @param spacious [Boolean] Whether to add margin to the bottom of the component.
    # @param dismissible [Boolean] Whether the component can be dismissed with an X button.
    # @param icon [String] Name of Octicon icon to use.
    # @param variant [Symbol] <%= one_of(Primer::FlashComponent::VARIANT_MAPPINGS.keys) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(full: false, spacious: false, dismissible: false, icon: nil, variant: DEFAULT_VARIANT, **system_arguments)
      @icon = icon
      @dismissible = dismissible
      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "flash",
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_MAPPINGS.keys, variant, DEFAULT_VARIANT)],
        "flash-full": full
      )
      @system_arguments[:mb] ||= spacious ? 4 : nil
    end

    class Actions < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :system_arguments

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(@system_arguments[:classes], "flash-action")
      end
    end
  end
end
