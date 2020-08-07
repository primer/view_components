# frozen_string_literal: true

require "primer/view_components/version"
require "primer/view_components/configuration"

module Primer
  module ViewComponents
    class << self
      def config
        @config ||= Configuration.new
      end

      def reset
        @config = Configuration.new
      end

      def configure
        yield(config)
      end

      def autoload?
        config.autoload
      end
    end
  end
end
