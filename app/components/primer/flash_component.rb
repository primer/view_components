# frozen_string_literal: true
module Primer
  class FlashComponent < Primer::Component
    def initialize(**kwargs)
      @kwargs = kwargs

      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(@kwargs[:classes], "flash")
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
