# frozen_string_literal: true

# The test environment is used exclusively to run your application's
# test suite. You never need to work with it otherwise. Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs. Don't rely on the data there!

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = false
  config.action_view.cache_template_loading = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = true

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=3600"
  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  config.assets.debug = true

  config.assets.check_precompiled_asset = false

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true
  config.primer_view_components.silence_deprecations = true
  config.primer_view_components.raise_on_invalid_options = true

  config.autoload_paths << Rails.root.join("..", "test", "forms")
  config.view_component.preview_paths << Rails.root.join("..", "test", "previews")

  # rubocop:disable Style/IfUnlessModifier
  if ENV.fetch("VC_COMPAT_PATCH_ENABLED", "false") == "true"
    config.view_component.capture_compatibility_patch_enabled = true
  end
  # rubocop:enable Style/IfUnlessModifier
end
