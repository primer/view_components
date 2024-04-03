# frozen_string_literal: true

module Primer
  module KeyboardTestHelpers
    class Keyboard
      include Primer::DriverTestHelpers

      attr_reader :page

      def initialize(page)
        @page = page
      end

      def type(*keys)
        if firefox?
          keys.each { |key| page.driver.send_keys(key) }
        elsif chrome?
          page.driver.browser.keyboard.type(*keys)
        end
      end
    end

    def keyboard
      @keyboard ||= Keyboard.new(page)
    end
  end
end
