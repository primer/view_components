# frozen_string_literal: true

module Primer
  class SelectMenuBlankslateComponent < Primer::Component
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        "SelectMenu-blankslate",
        kwargs[:classes],
      )
    end

    def component
      Primer::BaseComponent.new(**@kwargs)
    end
  end
end
