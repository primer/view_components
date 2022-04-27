# frozen_string_literal: true

module Primer
  # no doc
  class CounterComponentPreview < ViewComponent::Preview
    # @label Rounded
    #
    # @param scheme [Symbol] select [[Default, default], [Primary, primary], [Secondary, secondary]]]
    def default(scheme: :default)
      render(Primer::CounterComponent.new(count: 2, scheme: scheme))
    end
  end
end
