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

      def test_sub_lists
        render_preview(:sub_lists)

        assert_selector("h2.ActionList-sectionDivider-title")
        assert_selector("li.ActionListItem ul.ActionListWrap--subGroup")
        assert_selector("ul.ActionListWrap[aria-labelledby]")
        assert_selector(".ActionList-sectionDivider")
        assert_selector("ul.ActionListWrap--subGroup li.ActionListItem--subItem")
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

      def test_sub_items
        render_preview(:sub_items)

        assert_selector("button.ActionListContent--hasActiveSubItem.ActionListContent[aria-expanded='false'][data-action='click:action-list#handleItemWithSubItemClick'] svg.ActionListItem-collapseIcon")
        assert_selector(".ActionListItem--hasSubItem[data-action='click:action-list#handleItemClick'] .ActionList--subGroup .ActionListItem--subItem", text: "Sub item")
      end

      def test_item_with_leading_icon
        render_preview(:item, params: { leading_visual_icon: "arrow-down" })

        assert_selector(".octicon-arrow-down")
      end
    end
  end
end
