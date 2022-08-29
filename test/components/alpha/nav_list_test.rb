# frozen_string_literal: true

require "test_helper"

module Primer
  module Alpha
    class NavListTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_playground
        render_preview(:playground)
      end
    end
  end
end
