# frozen_string_literal: true

require "components/test_helper"

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

      def test_allows_content_arguments
        render_inline(Primer::Alpha::ActionList.new(aria: { label: "List" })) do |component|
          component.with_item(label: "Item 1", href: "/item1")
          component.with_item(label: "Item 2", href: "/item2", content_arguments: { data: { foo: "bar" } })
          component.with_item(label: "Item 3", href: "/item3")
        end

        assert_selector(".ActionListItem a[data-foo=bar]")
      end

      def test_renders_leading_visuals
        render_preview(:leading_visuals)

        assert_selector(".ActionListItem-visual--leading", count: 2)
      end

      def test_heading_denies_tag_argument
        error = assert_raises ArgumentError do
          render_inline(Primer::Alpha::ActionList.new(aria: { lable: "List" })) do |component|
            component.with_heading(title: "Foo", tag: :foo)
          end
        end

        assert_match(/This component has a fixed tag/, error.message)
      end

      def test_manual_dividers
        render_inline(Primer::Alpha::ActionList.new(aria: { label: "List" })) do |component|
          component.with_item(label: "Item 1", href: "/item1")
          component.with_item(label: "Item 2", href: "/item2")
          component.with_divider
          component.with_item(label: "Item 3", href: "/item3")
        end

        list_items = page.find_css("ul.ActionListWrap li").map do |list_item|
          classes = list_item["class"].split

          if classes.include?("ActionListItem")
            { type: :item, href: list_item.css("a").first["href"] }
          elsif classes.include?("ActionList-sectionDivider")
            { type: :divider }
          end
        end

        assert_equal list_items, [
          { type: :item, href: "/item1" },
          { type: :item, href: "/item2" },
          { type: :divider },
          { type: :item, href: "/item3" }
        ]
      end
    end
  end
end
