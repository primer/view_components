# frozen_string_literal: true

module Primer
  class TextComponent < Primer::Component
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] ||= :span
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
