# typed: false
# frozen_string_literal: true

require "test_helper"

module Primer
  module Experimental
    class ActionMenuTest < GitHub::TestCase
      include ActionView::Helpers::TagHelper
      include GitHub::ComponentTestHelpers

      def test_raises_if_no_menu_id_passed_in
        err = assert_raises ArgumentError do
          render_inline Primer::Experimental::ActionMenu.new do |component|
            component.with_trigger { "Trigger" }
            component.with_item(classes: "do-something-js") { "Does something" }
          end
        end
        assert_match(/missing keyword: :menu_id/, err.message)
      end

      def test_raises_error_if_no_action_is_passed_in
        err = assert_raises ArgumentError do
          render_inline Primer::Experimental::ActionMenu.new(menu_id: "no-action-menu-id") do |component|
            component.with_trigger { "Trigger" }
            component.with_item
            "<summary onclick='() => {}'>
                <details>
                Trying to pass in an interactive element with a nested action
                </details>
              </summary>"
          end
        end
        assert_includes err.message, "One of the following are required to apply functionality"
      end

      test "raises error if items and src are specified" do
        err = assert_raises ArgumentError do
          render_inline Primer::Experimental::ActionMenu.new(menu_id: "deferred-menu-items", src: "/") do |component|
            component.with_trigger { "Trigger" }
            component.with_item(classes: "do-something-js") { "Does something" }
          end
        end
        assert_equal "you cannot use `items` when `src` is specified", err.message
      end

      def test_renders_with_relevant_accessibility_attributes
        render_preview(:default)

        assert_selector("action-menu") do
          assert_selector("button[id='menu-1-text'][aria-haspopup='true'][aria-expanded='false']", text: "Trigger")
          assert_selector("ul[id='menu-1-list'][aria-labelledby='menu-1-text'][role='menu']", visible: false) do
            assert_selector("li[role='none']", visible: false) do
              assert_selector("span[role='menuitem']", text: "Does something", visible: false)
            end
          end
        end
      end

      def test_falls_back_to_span_if_non_allowed_tag_is_set_as_menu_item
        without_fetch_or_fallback_raises do
          render_inline Primer::Experimental::ActionMenu.new(menu_id: "bad-menu") do |component|
            component.with_trigger { "Trigger" }
            component.with_item(tag: :details, onclick: "() => {console.log('hey')}") { "Does something" }
          end
        end

        assert_selector("span[role='menuitem']", visible: false)
      end

      def test_falls_back_to_default_anchor_align_and_anchor_side_if_non_allowed_option_is_set
        without_fetch_or_fallback_raises do
          render_inline Primer::Experimental::ActionMenu.new(menu_id: "menu-1", anchor_side: :inside_out, anchor_align: :upside_down) do |component|
            component.with_trigger { "Trigger" }
            component.with_item(classes: "do-something-js") { "Does something" }
          end
        end

        assert_selector("action-menu[data-anchor-side='outside-bottom'][data-anchor-align='start']", visible: false)
      end

      def test_allows_trigger_button_to_be_icon_button
        render_preview(:with_icon_button)

        assert_selector("action-menu", visible: false) do
          assert_selector("button[id='menu-3-text'][aria-haspopup='true'][aria-expanded='false']", visible: false) do
            assert_selector("svg", visible: false)
          end
          assert_selector("tool-tip[for='menu-3-text']", text: "Menu", visible: false)
        end
      end

      def test_allows_some_tags_as_nested_menu_item
        render_preview(:with_items)

        assert_selector("action-menu") do
          assert_selector("button[id='menu-2-text'][aria-haspopup='true'][aria-expanded='false']", text: "Trigger")
          assert_selector("ul", visible: false) do
            assert_selector("li[role='none']", visible: false) do
              assert_selector("button[role='menuitem']", text: "Does something", visible: false)
            end
            assert_selector("li[role='none']", visible: false) do
              assert_selector("a[role='menuitem'][href='/']", text: "Site", visible: false)
            end
            assert_selector("li[role='none']", visible: false) do
              assert_selector("clipboard-copy[role='menuitem']", text: "Copy text", visible: false)
            end
          end
        end
      end

      test "renders with include-fragment if src is specified" do
        render_inline Primer::Experimental::ActionMenu.new(menu_id: "deferred-menu", src: "/") do |component|
          component.with_trigger { "Trigger" }
        end

        assert_selector("action-menu") do
          assert_selector("button[id='deferred-menu-text'][aria-haspopup='true'][aria-expanded='false']", text: "Trigger")
          assert_selector("ul", visible: false) do
            assert_selector("include-fragment[src='/'][data-target='action-menu.includeFragment']", visible: false) do
              assert_selector("li.ActionList-item[aria-disabled='true']", visible: false)
            end
          end
        end
      end

      test "renders include-fragment with preload" do
        render_inline Primer::Experimental::ActionMenu.new(
          menu_id: "deferred-menu",
          src: "/",
          preload: true
        ) do |component|
          component.with_trigger { "Trigger" }
        end

        assert_selector("action-menu[preload='true']") do
          assert_selector("button[id='deferred-menu-text'][aria-haspopup='true'][aria-expanded='false']", text: "Trigger")
          assert_selector("ul", visible: false) do
            assert_selector("include-fragment[src='/'][data-target='action-menu.includeFragment']", visible: false) do
              assert_selector("li.ActionList-item[aria-disabled='true']", visible: false)
            end
          end
        end
      end
    end
  end
end
