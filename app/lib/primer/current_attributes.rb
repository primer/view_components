# frozen_string_literal: true

module Primer
  # :nodoc:
  class CurrentAttributes < ActiveSupport::CurrentAttributes
    attribute :nonce
  end
end
