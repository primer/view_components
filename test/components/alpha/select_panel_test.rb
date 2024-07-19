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

      # This test is only here for coverage purposes and should be refactored
      # when a full test suite is implemented.
      def test_adds_src_attribute
        render_preview(:remote_fetch)

        assert_selector("select-panel") do
          assert_selector("remote-input[src]")
        end
      end
    end
  end
end
