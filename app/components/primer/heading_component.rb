# frozen_string_literal: true

module Primer
  class HeadingComponent < Primer::Component
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] ||= :h1
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
