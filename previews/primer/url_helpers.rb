# frozen_string_literal: true

module Primer
  # :nodoc:
  module URLHelpers
    class << self
      # use send to avoid yard warning
      send :include, Rails.application.routes.url_helpers

      private

      def controller; end
    end
  end
end
