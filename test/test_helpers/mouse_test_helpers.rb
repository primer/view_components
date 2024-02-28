# frozen_string_literal: true

module Primer
  module MouseTestHelpers
    class Mouse
      include Primer::DriverTestHelpers

      attr_reader :page

      def initialize(page)
        @page = page
      end

      def click(x:, y:) # rubocop:disable Naming/MethodParameterName
        if firefox?
          page.driver.browser.action.move_to_location(x, y).click.perform
        elsif chrome?
          page.driver.browser.mouse.click(x: x, y: y)
        end
      end
    end

    def mouse
      @mouse ||= Mouse.new(page)
    end
  end
end
