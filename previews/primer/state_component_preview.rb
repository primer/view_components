# frozen_string_literal: true

module Primer
  # @label StateComponent
  class StateComponentPreview < ViewComponent::Preview
    # @label Default Options
    #
    # @param title [String]
    # @param tag [Symbol] select [span, div]
    # @param size [Symbol] select [default, small]
    # @param scheme [Symbol] select [default, open, closed, merged]
    def default(title: "State", scheme: :default, size: :default, tag: :span)
      render(Primer::StateComponent.new(title: title, scheme: scheme, size: size, tag: tag)) { "State" }
    end
  end
end
