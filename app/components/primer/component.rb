# frozen_string_literal: true

module Primer
  # @private
  class Component < ViewComponent::Base
    include ClassNameHelper
    include FetchOrFallbackHelper
    include OcticonsHelper
    include JoinStyleArgumentsHelper

    STATUSES = [
      :experimental,
      :beta,
      :recommended,
      :released,
    ]

    def self.status
    end
  end
end
