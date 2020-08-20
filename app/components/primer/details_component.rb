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

    with_content_areas :body
    with_slot :summary, class_name: "Summary"

    def initialize(overlay: OVERLAY_DEFAULT, button: BUTTON_DEFAULT, **kwargs)
      @button = fetch_or_fallback(BUTTON_OPTIONS, button.to_sym, BUTTON_DEFAULT)

      @kwargs = kwargs
      @kwargs[:tag] = :details
      @kwargs[:classes] = class_names(
        kwargs[:classes],
        OVERLAY_MAPPINGS[fetch_or_fallback(OVERLAY_MAPPINGS.keys, overlay.to_sym, OVERLAY_DEFAULT)],
        "details-reset" => @button == BUTTON_RESET
      )
    end

    def render?
      summary.present?
    end

    def summary_component
      return Primer::BaseComponent unless button?

      Primer::ButtonComponent
    end

    def button?
      @button == BUTTON_DEFAULT
    end

    class Summary < Primer::Slot
      attr_reader :kwargs
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :summary
        @kwargs[:role] = "button"
      end
    end
  end
end
