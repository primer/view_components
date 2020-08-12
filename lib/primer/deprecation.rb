# frozen_string_literal: true

require "active_support/deprecation"

module Primer
  module Deprecation
    class << self
      def warn(message)
        ActiveSupport::Deprecation.warn(message)
      end
    end
  end
end
