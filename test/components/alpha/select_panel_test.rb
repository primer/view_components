# frozen_string_literal: true

require "components/test_helper"

module Primer
  module Alpha
    class SelectPanelTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_renders_content
        render_preview(:default)

        assert_selector("select-panel") do
          assert_selector(".Overlay-headerFilter") do
            assert_selector("primer-text-field")
          end
        end
      end
    end
  end
end
