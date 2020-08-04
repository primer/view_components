# frozen_string_literal: true

module Primer
  class TextComponent < Primer::Component
    def initialize(**args)
      @args = args
    end

    def call
      render(Primer::BaseComponent.new(**{ tag: :span }.merge(@args))) { content }
    end
  end
end
