# frozen_string_literal: true

module Primer
  # @private
  class Slot < ViewComponent::Slot
    include ClassNameHelper
    include FetchOrFallbackHelper
    include JoinStyleArgumentsHelper
  end
end
