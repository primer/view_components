# frozen_string_literal: true

module Primer
  class Component < ViewComponent::Base
    include ClassNameHelper
    include FetchOrFallbackHelper
    include OcticonsHelper
  end
end
