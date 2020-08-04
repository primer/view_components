# frozen_string_literal: true

module Primer
  class BoxComponent < Primer::Component
    def initialize(**args)
      @args = args
    end

    def call
      render(Primer::BaseComponent.new(**{ tag: :div }.merge(@args))) { content }
    end
  end
end
