# frozen_string_literal: true

module Primer
  #
  # overlay - options are `none`, `default` and `dark`. Dictates the type of overlay to render with.
  # button - options are `default` and `reset`. default will make the target a default primer ``.btn`
  #          reset will remove all styles from the <summary> element.
  #
  class DetailsComponent < Primer::Component
    include ViewComponent::Slotable

    OVERLAY_DEFAULT = :none
    OVERLAY_MAPPINGS = {
      OVERLAY_DEFAULT => "",
      :default => "details-overlay",
      :dark => "details-overlay details-overlay-dark",
    }.freeze

    BUTTON_DEFAULT = :default
    BUTTON_RESET = :reset
    BUTTON_OPTIONS = [BUTTON_DEFAULT, BUTTON_RESET]

    with_slot :body, class_name: "Body"
    with_slot :summary, class_name: "Summary"

    def initialize(overlay: OVERLAY_DEFAULT, reset: false, **kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :details
      @kwargs[:classes] = class_names(
        kwargs[:classes],
        OVERLAY_MAPPINGS[fetch_or_fallback(OVERLAY_MAPPINGS.keys, overlay.to_sym, OVERLAY_DEFAULT)],
        "details-reset" => reset
      )
    end

    def render?
      summary.present? && body.present?
    end

    class Summary < Primer::Slot
      attr_reader :kwargs, :button
      def initialize(button: true, **kwargs)
        @button = button

        @kwargs = kwargs
        @kwargs[:tag] = :summary
        @kwargs[:role] = "button"
      end

      def component
        return Primer::BaseComponent.new(**kwargs) unless button

        Primer::ButtonComponent.new(**kwargs)
      end

      def button?
        @button == BUTTON_DEFAULT
      end
    end

    class Body < Primer::Slot
      attr_reader :kwargs
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] ||= :div
      end
    end
  end
end
