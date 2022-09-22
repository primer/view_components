# frozen_string_literal: true

require "test_helper"

module Primer
  module Alpha
    class NavListTest < Minitest::Test
      include Primer::ComponentTestHelpers

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
    end
  end
end
