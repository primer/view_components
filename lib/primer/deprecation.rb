# frozen_string_literal: true

require "active_support/deprecation"

module Primer
  module Deprecation
    class << self
      # :nocov:
      def warn(message)
        ActiveSupport::Deprecation.warn(message)
      end
      # :nocov:
    end
  end
end
