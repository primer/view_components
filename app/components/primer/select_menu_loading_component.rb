# frozen_string_literal: true

module Primer
  class SelectMenuLoadingComponent < Primer::Component
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        "SelectMenu-loading",
        kwargs[:classes],
      )
    end

    def component
      Primer::BaseComponent.new(**@kwargs)
    end
  end
end
