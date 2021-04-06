# frozen_string_literal: true

require "octicons_helper/helper"
require "view_component/version"

module Primer
  # @private
  class Component < ViewComponent::Base
    include ViewComponent::SlotableV2 unless ViewComponent::VERSION::STRING.to_f >= 2.28
    include ClassNameHelper
    include FetchOrFallbackHelper
    include OcticonsHelper
    include TestSelectorHelper
    include JoinStyleArgumentsHelper
    include ViewHelper
    include Status::Dsl
  end
end
