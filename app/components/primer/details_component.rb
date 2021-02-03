# frozen_string_literal: true

module Primer
  # Use DetailsComponent to reveal content after clicking a button.
  class DetailsComponent < Primer::Component
    include ViewComponent::Slotable

    NO_OVERLAY = :none
    OVERLAY_MAPPINGS = {
      NO_OVERLAY => "",
      :default => "details-overlay",
      :dark => "details-overlay details-overlay-dark"
    }.freeze

    with_slot :body, class_name: "Body"
    with_slot :summary, class_name: "Summary"

    # @param overlay [Symbol] Dictates the type of overlay to render with. <%= one_of(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys) %>
    # @param reset [Boolean] Defatuls to false. If set to true, it will remove the default caret and remove style from the summary element
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(overlay: NO_OVERLAY, reset: false, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :details
      @system_arguments[:classes] = class_names(
        system_arguments[:classes],
        OVERLAY_MAPPINGS[fetch_or_fallback(OVERLAY_MAPPINGS.keys, overlay, NO_OVERLAY)],
        "details-reset" => reset
      )
    end

    def render?
      summary.present? && body.present?
    end

    # Use the Summary slot  as the trigger button
    class Summary < Primer::Slot
      # @param button [Boolean] If there should be a button or not
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(button: true, **system_arguments)
        @button = button

        @system_arguments = system_arguments
        @system_arguments[:tag] = :summary
        @system_arguments[:role] = "button"
      end

      def component
        return Primer::BaseComponent.new(**@system_arguments) unless @button

        Primer::ButtonComponent.new(**@system_arguments)
      end
    end

    # Use the Body slot as the main content to be shown when triggered by the Summary
    class Body < Primer::Slot
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] ||= :div
      end

      def component
        Primer::BaseComponent.new(**@system_arguments)
      end
    end
  end
end
