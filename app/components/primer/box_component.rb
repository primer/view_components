# frozen_string_literal: true

module Primer
  class BoxComponent < Primer::Component
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
