# frozen_string_literal: true

module Primer
  # @private
  class Component < ViewComponent::Base
    include ClassNameHelper
    include FetchOrFallbackHelper
    include OcticonsHelper
    include JoinStyleArgumentsHelper

    STATUSES = {
      experimental: :experimental,
      beta: :beta,
      recommended: :recommended,
      stable: :stable,
    }

    def self.status
      STATUSES[:experimental]
    end
  end
end
