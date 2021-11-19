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
    include Audited::Dsl

    private

    def raise_on_invalid_options?
      Rails.application.config.primer_view_components.raise_on_invalid_options
    end

    def deprecated_component_warning(new_class: nil, version: nil)
      return if Rails.env.production? || silence_deprecations?

      message = "#{self.class.name} is deprecated"
      message += " and will be removed in v#{version}." if version
      message += " Use #{new_class.name} instead." if new_class

      ActiveSupport::Deprecation.warn(message)
    end

    def aria(val, system_arguments)
      system_arguments[:"aria-#{val}"] || system_arguments.dig(:aria, val.to_sym)
    end

    def validate_aria_label
      aria_label = aria("label", @system_arguments)
      raise ArgumentError, "`aria-label` is required." if aria_label.nil? && !Rails.env.production?
    end

    def silence_deprecations?
      Rails.application.config.primer_view_components.silence_deprecations
    end

    def check_denylist(denylist = [], **arguments)
      if raise_on_invalid_options? && !ENV["PRIMER_WARNINGS_DISABLED"]

        # Convert denylist from:
        # { [:p, :pt] => "message" } to:
        # { p: "message", pt: "message" }
        unpacked_denylist =
          denylist.each_with_object({}) do |(keys, value), memo|
            keys.each { |key| memo[key] = value }
          end

        violations = unpacked_denylist.keys & arguments.keys

        if violations.any?
          message = "Found #{violations.count} #{'violation'.pluralize(violations)}:"
          violations.each do |violation|
            message += "\n The #{violation} argument is not allowed here. #{unpacked_denylist[violation]}"
          end

          raise(ArgumentError, message)
        end
      end

      arguments
    end

    def validate_arguments(denylist_name: :system_arguments_denylist, **arguments)
      deny_single_argument(:class, "Use `classes` instead.", **arguments)

      if (denylist = arguments[denylist_name])
        check_denylist(denylist, **arguments)

        # Remove :system_arguments_denylist key and any denied keys from system arguments
        arguments.except!(denylist_name)
        arguments.except!(*denylist.keys.flatten)
      end

      arguments
    end

    def deny_single_argument(key, help_text, **arguments)
      raise ArgumentError, "`#{key}` is an invalid argument. #{help_text}" \
        if raise_on_invalid_options? && !ENV["PRIMER_WARNINGS_DISABLED"] && arguments.key?(key)

      arguments.except!(key)
    end

    def deny_tag_argument(**arguments)
      deny_single_argument(:tag, "This component has a fixed tag.", **arguments)
    end
  end
end
