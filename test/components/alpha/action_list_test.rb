# frozen_string_literal: true

require "test_helper"

module Primer
  module Alpha
    class ActionListTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_invalid_list
        error = assert_raises ArgumentError do
          render_inline(Primer::Alpha::ActionList.new)
        end

        assert_includes(error.message, "label or heading must be provided")
      end

      def test_active_item
        render_preview(:item, params: { active: true })

        assert_selector(".ActionListItem--navActive")
      end

      def test_item_with_actions
        render_preview(:item, params: { trailing_action: "arrow-down" })

        assert_selector(".ActionListItem--withActions")
      end

      def test_item_tooltip
        render_preview(:item, params: { tooltip: true })

        assert_selector(".ActionListItem > tool-tip")
      end

      def test_item_trailing_action_on_hover
        render_preview(:item, params: { trailing_action: "arrow-down", trailing_action_on_hover: true })

        assert_selector(".ActionListItem--trailingActionHover")
      end

      def test_item_leading_visual_avatar
        render_preview(:item, params: { leading_visual_avatar_src: "/" })

        assert_selector(".avatar-small")
      end

      def test_item_trailing_visual_text
        render_preview(:item, params: { trailing_visual_text: "trailing visual text" })

        assert_text("trailing visual text")
      end

      def test_item_with_leading_icon
        render_preview(:item, params: { leading_visual_icon: "arrow-down" })

        assert_selector(".octicon-arrow-down")
      end

      def test_list_labelled_by_heading
        render_preview(:default)

        id = page.find_css(".ActionList-sectionDivider h3")[0].attributes["id"].value
        assert_selector("ul.ActionListWrap[aria-labelledby='#{id}']")
      end
    end
  end
end
