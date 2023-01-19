# frozen_string_literal: true

require "components/test_helper"

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
        assert_selector("ul.ActionListWrap--subGroup li.ActionListItem") do
          assert_selector("ul.ActionListWrap[aria-labelledby]")
          assert_selector(".ActionList-sectionDivider")
          assert_selector("ul.ActionListWrap--subGroup li.ActionListItem--subItem")
        end
      end

      def test_no_selected_item
        render_inline(Primer::Alpha::NavList.new) do |component|
          component.with_section(aria: { label: "Nav list" }) do |section|
            section.with_item(label: "Item 1", href: "/item1", selected_by_ids: :item1)
            section.with_item(label: "Item 2", href: "/item2", selected_by_ids: :item2)
          end
        end

        refute_selector ".ActionListItem--navActive"
      end

      def test_selected_item
        render_inline(Primer::Alpha::NavList.new(selected_item_id: :item2)) do |component|
          component.with_section(aria: { label: "Nav list" }) do |section|
            section.with_item(label: "Item 1", href: "/item1", selected_by_ids: :item1)
            section.with_item(label: "Item 2", href: "/item2", selected_by_ids: :item2)
          end
        end

        refute_selector ".ActionListItem--navActive", text: "Item 1"
        assert_selector ".ActionListItem--navActive", text: "Item 2"
      end

      def test_item_can_be_selected_by_any_of_its_ids
        render_inline(Primer::Alpha::NavList.new(selected_item_id: :other_item1_id)) do |component|
          component.with_section(aria: { label: "Nav list" }) do |section|
            section.with_item(label: "Item 1", href: "/item1", selected_by_ids: [:item1, :other_item1_id])
            section.with_item(label: "Item 2", href: "/item2", selected_by_ids: :item2)
          end
        end

        assert_selector ".ActionListItem--navActive", text: "Item 1"
        refute_selector ".ActionListItem--navActive", text: "Item 2"
      end

      class CurrentPageItem < Primer::Alpha::NavList::Item
        def initialize(current_page_href:, **system_arguments)
          @current_page_href = current_page_href
          super(**system_arguments)
        end

        private

        def current_page?(url)
          url == @current_page_href
        end
      end

      def test_item_can_be_selected_by_current_page
        current_page_href = "/item2"

        render_inline(Primer::Alpha::NavList.new) do |component|
          component.with_section(aria: { label: "Nav list" }) do |section|
            # use CurrentPageItem instead of a mock since the API supports it
            section.with_item(component_klass: CurrentPageItem, label: "Item 1", href: "/item1", current_page_href: current_page_href)
            section.with_item(component_klass: CurrentPageItem, label: "Item 2", href: "/item2", current_page_href: current_page_href)
          end
        end

        refute_selector ".ActionListItem--navActive", text: "Item 1"
        assert_selector ".ActionListItem--navActive", text: "Item 2"
      end

      def test_max_nesting_depth
        error = assert_raises(RuntimeError) do
          render_inline(Primer::Alpha::NavList.new) do |component|
            component.with_section(aria: { label: "Nav list" }) do |section|
              section.with_item(label: "Item at level 1", href: "/item_level_1") do |item|
                item.with_item(label: "Item at level 2", href: "/item_level_2") do |sub_item|
                  sub_item.with_item(label: "Item at level 3", href: "/item_level_3")
                end
              end
            end
          end
        end

        assert_equal "Items can only be nested 2 levels deep", error.message
      end

      def test_show_more_item
        render_preview(:show_more_item)

        assert_selector("#ActionList--showMoreItem", visible: false, text: "Show more")
      end

      def test_disallow_subitems_and_trailing_action
        error = assert_raises(RuntimeError) do
          render_inline(Primer::Alpha::NavList.new) do |component|
            component.with_section(aria: { label: "List" }) do |section|
              section.with_item(label: "Level 1", href: "/level1") do |item|
                item.with_item(label: "Level 2", href: "/level2")
                item.with_trailing_action(icon: :megaphone, aria: { label: "Action" })
              end
            end
          end
        end

        assert_equal "Cannot render a trailing action for an item with subitems", error.message
      end
    end
  end
end
