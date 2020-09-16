# frozen_string_literal: true

module Primer
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

    def initialize(full: false, spacious: false, dismissible: false, icon: nil, variant: DEFAULT_VARIANT, **kwargs)
      @icon = icon
      @dismissible = dismissible
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        @kwargs[:classes],
        "flash",
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_MAPPINGS.keys, variant.to_sym, DEFAULT_VARIANT)],
        "flash-full": full
      )
      @kwargs[:mb] ||= spacious ? 4 : nil
    end

    class Actions < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :kwargs

      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(@kwargs[:classes], "flash-action")
      end
    end
  end
end
