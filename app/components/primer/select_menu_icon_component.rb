# frozen_string_literal: true

module Primer
  class SelectMenuIconComponent < Primer::Component
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:icon] ||= "check"
      @kwargs[:classes] = class_names(
        "SelectMenu-icon SelectMenu-icon--check",
        kwargs[:classes],
      )
    end

    def component
      Primer::OcticonComponent.new(**@kwargs)
    end
  end
end
