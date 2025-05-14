# frozen_string_literal: true

module Primer
  # `Primer::CurrentAttributes` can be used by controllers to set request-bound data
  # that can be propagated to components.
  class CurrentAttributes < ActiveSupport::CurrentAttributes
    attribute :nonce
  end
end
