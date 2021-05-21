# frozen_string_literal: true

require "view_component/version"

module Primer
  # @private
  class Component < ViewComponent::Base
    include ViewComponent::SlotableV2 unless ViewComponent::Base < ViewComponent::SlotableV2
    include ClassNameHelper
    include FetchOrFallbackHelper
    include TestSelectorHelper
    include JoinStyleArgumentsHelper
    include ViewHelper
    include Status::Dsl

    private

    def deprecated_component_warning(new_class: nil, version: nil)
      return if Rails.env.production? || silence_deprecations?

      message = "#{self.class.name} is deprecated"
      message += " and will be removed in v#{version}." if version
      message += " Use #{new_class.name} instead." if new_class

      ActiveSupport::Deprecation.warn(message)
    end

    def validate_aria_label
      aria_label = @system_arguments[:"aria-label"] || @system_arguments.dig(:aria, :label)
      raise ArgumentError, "`aria-label` is required." if aria_label.nil? && !Rails.env.production?
    end

    def silence_deprecations?
      Rails.application.config.primer_view_components.silence_deprecations
    end
  end
end
