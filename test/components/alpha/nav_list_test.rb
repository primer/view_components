# frozen_string_literal: true

require "test_helper"

module Primer
  module Alpha
    class NavListTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_sub_items
        render_preview(:default)

        assert_selector("button.ActionListContent--hasActiveSubItem.ActionListContent[aria-expanded='true']") do
          assert_selector("svg.ActionListItem-collapseIcon")
          assert_selector(".ActionList--subGroup .ActionListItem--subItem", text: "Interaction limits")
          assert_selector(".ActionList--subGroup .ActionListItem--subItem.ActionListItem--navActive", text: "Code review limits")
          assert_selector(".ActionList--subGroup .ActionListItem--subItem", text: "Reported content")
        end
      end

      def test_groups
        render_preview(:default)

        assert_selector("h3.ActionList-sectionDivider-title")
        assert_selector("li.ActionListItem ul.ActionListWrap--subGroup")
        assert_selector("ul.ActionListWrap[aria-labelledby]")
        assert_selector(".ActionList-sectionDivider")
        assert_selector("ul.ActionListWrap--subGroup li.ActionListItem--subItem")
      end

      def test_no_selected_item
        render_inline(Primer::Alpha::NavList.new(aria: { label: "Nav list" })) do |c|
          c.with_item(label: "Item 1", href: "/item1", selected_by_ids: :item1)
          c.with_item(label: "Item 2", href: "/item2", selected_by_ids: :item2)
        end

        refute_selector ".ActionListItem--navActive"
      end

      def test_selected_item
        render_inline(Primer::Alpha::NavList.new(aria: { label: "Nav list" }, selected_item_id: :item2)) do |c|
          c.with_item(label: "Item 1", href: "/item1", selected_by_ids: :item1)
          c.with_item(label: "Item 2", href: "/item2", selected_by_ids: :item2)
        end

        refute_selector ".ActionListItem--navActive", text: "Item 1"
        assert_selector ".ActionListItem--navActive", text: "Item 2"
      end

      def test_item_can_be_selected_by_any_of_its_ids
        render_inline(Primer::Alpha::NavList.new(aria: { label: "Nav list" }, selected_item_id: :other_item1_id)) do |c|
          c.with_item(label: "Item 1", href: "/item1", selected_by_ids: [:item1, :other_item1_id])
          c.with_item(label: "Item 2", href: "/item2", selected_by_ids: :item2)
        end

        assert_selector ".ActionListItem--navActive", text: "Item 1"
        refute_selector ".ActionListItem--navActive", text: "Item 2"
      end

      def test_max_nesting_depth
        error = assert_raises(RuntimeError) do
          render_inline(Primer::Alpha::NavList.new(aria: { label: "Nav list" })) do |c|
            c.with_group do |group|
              group.with_item(label: "Item at level 1", href: "/item_level_1") do |item|
                item.with_item(label: "Item at level 2", href: "/item_level_2") do |sub_item|
                  sub_item.with_item(label: "Item at level 3", href: "/item_level_3")
                end
              end
            end
          end
        end

        assert_equal "Items can only be nested 2 levels deep", error.message
      end
    end
  end
end
