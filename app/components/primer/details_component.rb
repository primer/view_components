# frozen_string_literal: true

module Primer
  #
  # overlay - options are `none`, `default` and `dark`. Dictates the type of page overlay to render with.
  # reset - Boolean; true will result in `details-reset` on the details element
  #
  class DetailsComponent < Primer::Component
    include ViewComponent::Slotable

    OVERLAY_DEFAULT = :none
    OVERLAY_MAPPINGS = {
      OVERLAY_DEFAULT => "",
      :default => "details-overlay",
      :dark => "details-overlay details-overlay-dark",
    }.freeze

    attr_reader :reset
    with_slot :summary, class_name: "Summary"
    with_slot :body, class_name: "Body"

    def initialize(overlay: OVERLAY_DEFAULT, reset: false, **kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :details
      @reset = reset
      @kwargs[:classes] = class_names(
        kwargs[:classes],
        OVERLAY_MAPPINGS[fetch_or_fallback(OVERLAY_MAPPINGS.keys, overlay, OVERLAY_DEFAULT)],
        "details-reset" => @reset
      )
    end

    def render?
      summary.present? && body.present?
    end

    class Summary < ViewComponent::Slot
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:mb] ||= 2
        @kwargs[:tag] ||= :summary
        @kwargs[:role] ||= "button" if @kwargs[:tag] == :summary
        @kwargs[:classes] ||= "btn"
      end

      def component
        Primer::BaseComponent.new(**@kwargs)
      end
    end

    class Body < ViewComponent::Slot
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] ||= :div
      end

      def component
        Primer::BaseComponent.new(**@kwargs)
      end
    end
  end
end
