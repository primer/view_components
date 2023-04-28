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

        assert_includes(error.message, "aria-label, aria-labelledby, or heading must be provided")
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

      def test_allows_custom_item_tag
        render_inline(Primer::Alpha::ActionList.new(aria: { label: "List" })) do |component|
          component.with_item(label: "Item 1", content_arguments: { tag: :"clipboard-copy" })
        end

        assert_selector("clipboard-copy.ActionListContent")
      end

      def test_uses_list_role_when_select_disabled
        render_inline(Primer::Alpha::ActionList.new(aria: { label: "List" })) do |component|
          component.with_item(label: "Item 1")
        end

        assert_selector("ul.ActionListWrap[role=list]") do
          assert_selector("li.ActionListItem button")
        end
      end

      def test_uses_correct_menu_and_item_roles_when_single_select
        render_inline(Primer::Alpha::ActionList.new(aria: { label: "List" }, select_variant: :single)) do |component|
          component.with_item(label: "Item 1")
        end

        assert_selector("ul.ActionListWrap[role=menu]") do
          assert_selector("li.ActionListItem button[role=menuitemradio]")
        end
      end

      def test_uses_correct_menu_and_item_roles_when_multi_select
        render_inline(Primer::Alpha::ActionList.new(aria: { label: "List" }, select_variant: :multiple)) do |component|
          component.with_item(label: "Item 1")
        end

        assert_selector("ul.ActionListWrap[role=menu]") do
          assert_selector("li.ActionListItem button[role=menuitemcheckbox]")
        end
      end

      def test_uses_correct_item_role_when_role_set_to_menu
        render_inline(Primer::Alpha::ActionList.new(aria: { label: "List" }, role: :menu)) do |component|
          component.with_item(label: "Item 1")
        end

        assert_selector("ul.ActionListWrap[role=menu]") do
          assert_selector("li.ActionListItem button[role=menuitem]")
        end
      end

      def test_raises_when_two_items_selected_under_single_select
        error = assert_raises ArgumentError do
          render_inline(Primer::Alpha::ActionList.new(aria: { label: "List" }, select_variant: :single)) do |component|
            component.with_item(label: "Item 1", active: true)
            component.with_item(label: "Item 2", active: true)
          end
        end

        assert_match(/only a single item may be active/, error.message)
      end

      def test_raises_when_non_button_tag_passed_to_form_item
        error = assert_raises ArgumentError do
          render_inline(Primer::Alpha::ActionList.new(aria: { label: "List" })) do |component|
            component.with_item(label: "Item 1")
            component.with_item(
              label: "Item 2",
              href: "/foo",
              content_arguments: { tag: :span },
              form_arguments: { method: :post, name: "foo" }
            )
          end
        end

        assert_equal 'items that submit forms must use a "button" tag instead of "span"', error.message
      end

      def test_raises_when_non_button_item_added_to_list_acting_as_form_input
        error = assert_raises ArgumentError do
          render_in_view_context do
            form_with(url: "/foo") do |f|
              render(Primer::Alpha::ActionList.new(aria: { label: "List" }, select_variant: :single, form_arguments: { builder: f, name: "foo" })) do |component|
                component.with_item(label: "Item 1")
                component.with_item(label: "Item 2", content_arguments: { tag: :span })
              end
            end
          end
        end

        assert_equal 'items within lists/menus that act as form inputs must use "button" tags instead of "span"', error.message
      end

      def test_raises_when_list_acting_as_form_input_doesnt_allow_selection
        error = assert_raises ArgumentError do
          render_in_view_context do
            form_with(url: "/foo") do |f|
              render(Primer::Alpha::ActionList.new(aria: { label: "List" }, form_arguments: { builder: f, name: "foo" })) do |component|
                component.with_item(label: "Item 1")
                component.with_item(label: "Item 2", content_arguments: { tag: :span })
              end
            end
          end
        end

        assert_match(%r{lists/menus that act as form inputs must also allow item selection}, error.message)
      end
    end
  end
end
