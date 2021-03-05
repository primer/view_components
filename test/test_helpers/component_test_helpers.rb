# frozen_string_literal: true

module Primer
  module ComponentTestHelpers
    include ViewComponent::TestHelpers

    # For components using fetch_or_fallback,
    # we want to ensure that the correct
    # fallback behavior works in production.
    # The helper enables us to easily test
    # this production-only behavior.
    def without_fetch_or_fallback_raises
      FetchOrFallbackHelper.fallback_raises = false
      yield
    ensure
      FetchOrFallbackHelper.fallback_raises = true
    end

    def with_force_functional_colors(new_value)
      old_value = Rails.application.config.primer_view_component.force_functional_colors
      Rails.application.config.primer_view_component.force_functional_colors = new_value
      yield
      Rails.application.config.primer_view_component.force_functional_colors = old_value
    end

    def assert_component_state(component, state)
      assert_equal component.status, Primer::Component::STATUSES[state]
    end
  end
end
