# frozen_string_literal: true

module Primer
  module WindowTestHelpers
    class Window
      include Primer::DriverTestHelpers

      attr_reader :page, :driver_name

      def initialize(page)
        @page = page
      end

      def resize(width:, height:)
        if firefox?
          page.driver.browser.manage.window.resize_to(width, height)
        elsif chrome?
          page.driver.browser.resize(width: width, height: height)
        end
      end

      def viewport_size
        if firefox?
          size = page.driver.browser.manage.window.size
          [size.width, size.height]
        elsif chrome?
          page.driver.browser.viewport_size
        end
      end
    end

    module MethodOverrides
      def setup
        @original_width, @original_height = window.viewport_size
        super
      end

      def teardown
        # When running in Firefox, Capybara does not automatically resize the window after
        # individual tests, so we manually reset it here
        if window.viewport_size != [@original_width, @original_height]
          window.resize(width: @original_width, height: @original_height)
        end
      end
    end

    def self.included(base)
      base.prepend(MethodOverrides)
    end

    def window
      @window ||= Window.new(page)
    end
  end
end
