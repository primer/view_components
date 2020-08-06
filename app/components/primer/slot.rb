# frozen_string_literal: true

module Primer
  class Slot < ViewComponent::Slot
    include ClassNameHelper
    include FetchOrFallbackHelper
  end
end
