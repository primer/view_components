# typed: true
# frozen_string_literal: true

require "test_helper"

module Primer
  module Experimental
    class ActionMenuItemTest < GitHub::TestCase
      include GitHub::ComponentTestHelpers

      def test_renders_item_with_span_by_default
        render_inline(Primer::Experimental::ActionMenu::Item.new(classes: "do-something-js")) { "Default" }

        assert_selector("li.ActionList-item[role='none']") do
          assert_selector("span.ActionList-content[role='menuitem']") do
            assert_selector("span.ActionList-item-label", text: "Default")
          end
        end
      end

      def test_falls_back_to_span_if_non_allowed_tag_is_set_as_menu_item
        without_fetch_or_fallback_raises do
          render_inline(Primer::Experimental::ActionMenu::Item.new(tag: :details, onclick: "() => {}")) { "Default" }
        end

        assert_selector("li.ActionList-item[role='none']") do
          assert_selector("span.ActionList-content[role='menuitem']") do
            assert_selector("span.ActionList-item-label", text: "Default")
          end
        end
      end

      def test_allows_some_interactive_elements_as_menu_item
        render_inline(Primer::Experimental::ActionMenu::Item.new(tag: :a, href: "/")) { "Link" }
        assert_selector("li.ActionList-item[role='none']") do
          assert_selector("a[role='menuitem'][href='/']") do
            assert_selector("span.ActionList-item-label", text: "Link")
          end
        end
      end

      def test_passes_onclick_to_button_item
        render_inline(Primer::Experimental::ActionMenu::Item.new(tag: :button, type: "button", onclick: "() => {}")) { "Button with Action" }

        assert_selector("button[onclick='() => {}']", visible: false)
      end

      def test_renders_item_as_divider
        render_inline(Primer::Experimental::ActionMenu::Item.new(is_divider: true))
        assert_selector("li.ActionList-sectionDivider[role='presentation']")
      end

      def test_renders_item_as_dangerous
        render_inline(Primer::Experimental::ActionMenu::Item.new(is_dangerous: true, onclick: "() => {}")) { "Dangerous" }
        assert_selector("li.ActionList-item.ActionList-item--danger[role='none']") do
          assert_selector("span[role='menuitem']") do
            assert_selector("span.ActionList-item-label", text: "Dangerous")
          end
        end
      end
    end
  end
end
