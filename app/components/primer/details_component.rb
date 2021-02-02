# frozen_string_literal: true

module Primer
  #
  # overlay - options are `none`, `default` and `dark`. Dictates the type of overlay to render with.
  # button - options are `default` and `reset`. default will make the target a default primer ``.btn`
  #          reset will remove all styles from the <summary> element.
  #
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

    class Summary < Primer::Slot
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

    class Body < Primer::Slot
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
