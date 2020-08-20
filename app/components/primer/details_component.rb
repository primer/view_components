# frozen_string_literal: true

module Primer
  #
  # overlay - options are `none`, `default` and `dark`. Dictates the type of overlay to render with.
  # button - options are `default` and `reset`. default will make the target a default primer ``.btn`
  #          reset will remove all styles from the <summary> element.
  #
  class DetailsComponent < Primer::Component
    OVERLAY_DEFAULT = :none
    OVERLAY_MAPPINGS = {
      OVERLAY_DEFAULT => "",
      :default => "details-overlay",
      :dark => "details-overlay details-overlay-dark",
    }.freeze

    BUTTON_DEFAULT = :default
    BUTTON_RESET = :reset
    BUTTON_OPTIONS = [BUTTON_DEFAULT, BUTTON_RESET]

    with_content_areas :summary, :body

    def initialize(overlay: OVERLAY_DEFAULT, button: BUTTON_DEFAULT, **kwargs)
      @button = fetch_or_fallback(BUTTON_OPTIONS, button.to_sym, BUTTON_DEFAULT)

      @kwargs = kwargs
      @kwargs[:tag] = :details
      @kwargs[:classes] = class_names(
        kwargs[:classes],
        OVERLAY_MAPPINGS[fetch_or_fallback(OVERLAY_MAPPINGS.keys, overlay.to_sym, OVERLAY_DEFAULT)],
        "details-reset" => @button == BUTTON_RESET
      )

      @summary_kwargs = { tag: :summary, role: "button" }
      @summary_kwargs[:classes] = "btn" if @button == BUTTON_DEFAULT
    end
  end
end
