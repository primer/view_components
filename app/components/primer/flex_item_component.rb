# frozen_string_literal: true

module Primer
  class FlexItemComponent < Primer::Component
    FLEX_AUTO_DEFAULT = false
    FLEX_AUTO_ALLOWED_VALUES = [FLEX_AUTO_DEFAULT, true].freeze

    def initialize(flex_auto: FLEX_AUTO_DEFAULT, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:classes] =
        class_names(
          @system_arguments[:classes],
          "flex-auto" => fetch_or_fallback(FLEX_AUTO_ALLOWED_VALUES, flex_auto, FLEX_AUTO_DEFAULT)
        )
    end

    def call
      render(Primer::BoxComponent.new(**@system_arguments)) { content }
    end
  end
end
