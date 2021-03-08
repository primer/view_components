# frozen_string_literal: true

require "octicons_helper/helper"

module Primer
  # @private
  class Component < ViewComponent::Base
    include ClassNameHelper
    include FetchOrFallbackHelper
    include OcticonsHelper
    include JoinStyleArgumentsHelper
    include ViewHelper::Dsl
    include ViewHelper
    include Status::Dsl
  end
end
