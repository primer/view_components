# frozen_string_literal: true

module Primer
  # @private
  class Component < ViewComponent::Base
    include ClassNameHelper
    include FetchOrFallbackHelper
    include OcticonsHelper
    include JoinStyleArgumentsHelper

    # sourced from https://primer.style/doctocat/usage/front-matter#status
    STATUSES = {
      deprecated: :deprecated,
      review: :review,
      experimental: :experimental,
      new: :new,
      stable: :stable,
    }

    def self.status
      STATUSES[:experimental]
    end
  end
end
