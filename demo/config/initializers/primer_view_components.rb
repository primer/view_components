# frozen_string_literal: true

require "primer/view_components"

Primer::ViewComponents.configure do |config|
  config.autoload = Rails.env.development?
end

require "primer/view_components/engine" unless Rails.env.test?
