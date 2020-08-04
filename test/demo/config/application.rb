# frozen_string_literal: true

require_relative "boot"

require "rails/all"
require "view_component/engine"
require "view_component/storybook/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.view_component_storybook.stories_path = Rails.root.join("../components/stories")
    config.action_dispatch.default_headers.clear

    config.action_dispatch.default_headers = {
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Request-Method' => %w{GET}.join(",")
    }
  end
end

require "primer/view_components/engine"
