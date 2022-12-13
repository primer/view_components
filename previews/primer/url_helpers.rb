# frozen_string_literal: true

module Primer
  module URLHelpers
    class << self
      # use send to avoid yard warning
      send :include, Rails.application.routes.url_helpers

      private

      def controller; end
    end
  end
end
