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

    def with_raise_on_invalid_options(new_value)
      old_value = Rails.application.config.primer_view_components.raise_on_invalid_options
      Rails.application.config.primer_view_components.raise_on_invalid_options = new_value
      yield
    ensure
      Rails.application.config.primer_view_components.raise_on_invalid_options = old_value
    end

    def with_raise_on_invalid_aria(new_value)
      old_value = Rails.application.config.primer_view_components.raise_on_invalid_aria
      Rails.application.config.primer_view_components.raise_on_invalid_aria = new_value
      yield
    ensure
      Rails.application.config.primer_view_components.raise_on_invalid_aria = old_value
    end

    def with_silence_deprecations(new_value)
      old_value = Rails.application.config.primer_view_components.silence_deprecations
      Rails.application.config.primer_view_components.silence_deprecations = new_value
      yield
    ensure
      Rails.application.config.primer_view_components.silence_deprecations = old_value
    end

    def with_validate_class_names(new_value)
      old_value = Primer::Classify::Utilities.validate_class_names
      Primer::Classify::Utilities.validate_class_names = new_value
      yield
    ensure
      Primer::Classify::Utilities.validate_class_names = old_value
    end

    def with_env(env)
      old_env = ENV.to_hash
      ENV.replace(old_env.merge(env))
      yield
    ensure
      ENV.replace(old_env)
    end

    def assert_component_state(component, state)
      assert_equal component.status, Primer::Component::STATUSES[state]
    end

    def assert_selector(*args, message: nil, **kwargs, &block)
      super(*args, **kwargs, &block)
    rescue ::Minitest::Assertion => e
      raise unless message

      raise ::Minitest::Assertion, "#{message}: #{e.message}"
    end

    class DummyComponent
      def self.type
        "text/html"
      end

      def self.identifier
        source_location
      end
    end

    def render_inline_erb(erb)
      @page = nil
      handler = ActionView::Template.handler_for_extension("erb")
      erb_code = handler.call(DummyComponent, erb)
      view_context = vc_test_controller.view_context
      @rendered_content = view_context.capture { view_context.instance_eval(erb_code) }
      Nokogiri::HTML.fragment(@rendered_content)
    end
  end
end
