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

    private

    def deprecated_component_warning(new_class: nil)
      return if Rails.env.production? || silence_deprecations?

      message = if new_class
                  "#{self.class.name} is deprecated, please use #{new_class.name} instead."
                else
                  "#{self.class.name} is deprecated and should not be used."
      end

      ActiveSupport::Deprecation.warn(message)
    end

    def silence_deprecations?
      Rails.application.config.primer_view_components.silence_deprecations
    end
  end
end
