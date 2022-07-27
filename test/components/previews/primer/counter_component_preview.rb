# frozen_string_literal: true

module Primer
  class CounterComponentPreview < ViewComponent::Preview
    def default
      render(Primer::CounterComponent.new(count: 2))
    end
  end
end
