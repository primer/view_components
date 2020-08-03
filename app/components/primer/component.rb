# frozen_string_literal: true

module Primer
  class Component < ViewComponent::Base
    include ClassNameHelper
    include FetchOrFallbackHelper
  end
end
