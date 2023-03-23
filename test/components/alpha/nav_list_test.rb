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
          assert_selector("ul.ActionList--subGroup[role=list]") do |sub_group|
            sub_group.assert_selector("li.ActionListItem--subItem", text: "Interaction limits")
            sub_group.assert_selector("li.ActionListItem--subItem.ActionListItem--navActive", text: "Code review limits")
            sub_group.assert_selector("li.ActionListItem--subItem", text: "Reported content")
          end
        end
      end

      def test_groups
        render_preview(:default)

        assert_selector("h3.ActionList-sectionDivider-title")

        assert_selector("ul.ActionListWrap[role=list] li.ActionListItem", text: "Moderation options") do |item|
          item.assert_selector("ul.ActionList.ActionList--subGroup[role=list] li.ActionListItem--subItem")
        end
      end

      def test_no_selected_item
        render_inline(Primer::Alpha::NavList.new) do |component|
          component.with_group(aria: { label: "Nav list" }) do |group|
            group.with_item(label: "Item 1", href: "/item1", selected_by_ids: :item1)
            group.with_item(label: "Item 2", href: "/item2", selected_by_ids: :item2)
          end
        end

        refute_selector ".ActionListItem--navActive"
      end

      def test_selected_item
        render_inline(Primer::Alpha::NavList.new(selected_item_id: :item2)) do |component|
          component.with_group(aria: { label: "Nav list" }) do |group|
            group.with_item(label: "Item 1", href: "/item1", selected_by_ids: :item1)
            group.with_item(label: "Item 2", href: "/item2", selected_by_ids: :item2)
          end
        end

        refute_selector ".ActionListItem--navActive", text: "Item 1"
        assert_selector ".ActionListItem--navActive", text: "Item 2"
      end

      def test_item_can_be_selected_by_any_of_its_ids
        render_inline(Primer::Alpha::NavList.new(selected_item_id: :other_item1_id)) do |component|
          component.with_group(aria: { label: "Nav list" }) do |group|
            group.with_item(label: "Item 1", href: "/item1", selected_by_ids: [:item1, :other_item1_id])
            group.with_item(label: "Item 2", href: "/item2", selected_by_ids: :item2)
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
          component.with_group(aria: { label: "Nav list" }) do |group|
            # use CurrentPageItem instead of a mock since the API supports it
            group.with_item(component_klass: CurrentPageItem, label: "Item 1", href: "/item1", current_page_href: current_page_href)
            group.with_item(component_klass: CurrentPageItem, label: "Item 2", href: "/item2", current_page_href: current_page_href)
          end
        end

        refute_selector ".ActionListItem--navActive", text: "Item 1"
        assert_selector ".ActionListItem--navActive", text: "Item 2"
      end

      def test_max_nesting_depth
        error = assert_raises(RuntimeError) do
          render_inline(Primer::Alpha::NavList.new) do |component|
            component.with_group(aria: { label: "Nav list" }) do |group|
              group.with_item(label: "Item at level 1") do |item|
                item.with_item(label: "Item at level 2") do |sub_item|
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
            component.with_group(aria: { label: "List" }) do |group|
              group.with_item(label: "Level 1", href: "/level1") do |item|
                item.with_item(label: "Level 2", href: "/level2")
                item.with_trailing_action(icon: :megaphone, aria: { label: "Action" })
              end
            end
          end
        end

        assert_equal "Cannot render a trailing action for an item with subitems", error.message
      end

      def test_disallows_aria_label_when_heading_provided
        error = assert_raises(ArgumentError) do
          render_inline(Primer::Alpha::NavList.new) do |component|
            component.with_group(aria: { label: "List" }) do |group|
              group.with_heading(title: "List")
            end
          end
        end

        assert_equal "An aria-label should not be provided if a heading is present", error.message
      end

      def test_errors_when_passing_selected_by_ids_to_parent
        error = assert_raises(RuntimeError) do
          render_inline(Primer::Alpha::NavList.new) do |component|
            component.with_group(aria: { label: "List" }) do |section|
              section.with_item(label: "Level 1", href: "/level1", selected_by_ids: :foo) do |item|
                item.with_item(label: "Level 2", href: "/level2")
              end
            end
          end
        end

        assert_equal "Cannot pass `selected_by_ids:` for an item with subitems, since parent items cannot be selected", error.message
      end

      def test_allows_customizing_heading_level
        render_inline(Primer::Alpha::NavList.new) do |component|
          component.with_group do |group|
            group.with_heading(title: "List", heading_level: 2)
          end
        end

        assert_selector "h2", text: "List"
      end

      def test_sub_lists_labeled_by_parent_button
        render_preview(:default)

        id = page.find_css("button.ActionListContent", text: "Moderation options").first[:id]
        assert_selector "ul.ActionList[aria-labelledby='#{id}']"
      end
    end
  end
end
