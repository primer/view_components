# frozen_string_literal: true

require "components/test_helper"

module Primer
  module Alpha
    class ActionBarTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_renders_action_menu_items_with_type_button
        render_preview(:default)

        assert_selector("action-menu[data-target=\"action-bar.moreMenu\"]", visible: :hidden) do
          assert_selector("button[type=\"button\"]")
        end
      end
    end
  end
end
