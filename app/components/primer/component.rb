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
      alpha: :alpha,
      beta: :beta,
      stable: :stable,
      deprecated: :deprecated,
    }.freeze

    def self.status
      STATUSES[:alpha]
    end
  end
end
