# frozen_string_literal: true

require "components/test_helper"

module Primer
  module Alpha
    class ActionMenuTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_raises_error_if_no_action_is_passed_in
        err = assert_raises ArgumentError do
          render_inline Primer::Alpha::ActionMenu.new(menu_id: "no-action-menu-id") do |component|
            component.with_show_button { "Trigger" }
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

      def test_raises_error_if_items_and_src_are_specified
        err = assert_raises ArgumentError do
          render_inline Primer::Alpha::ActionMenu.new(menu_id: "deferred-menu-items", src: "/") do |component|
            component.with_show_button { "Trigger" }
            component.with_item(label: "Does something", classes: "do-something-js")
          end
        end
        assert_equal "`items` cannot be set when `src` is specified", err.message
      end

      def test_renders_with_relevant_accessibility_attributes
        render_preview(:default)

        assert_selector("action-menu") do
          assert_selector("button[id='overlay-show-menu-1'][aria-haspopup='true']", text: "Menu")
          assert_selector("ul[id='menu-1-list'][aria-labelledby='menu-1-text'][role='menu']", visible: false) do
            assert_selector("li[role='menuitem']", visible: false)
          end
        end
      end

      def test_falls_back_to_span_if_disallowed_tag_is_given
        without_fetch_or_fallback_raises do
          render_inline Primer::Alpha::ActionMenu.new(menu_id: "bad-menu") do |component|
            component.with_show_button { "Trigger" }
            component.with_item(tag: :details, label: "Does something", "onclick": "() => {console.log('hey')}")
          end
        end

        assert_selector("span.ActionListContent", visible: false)
      end

      def test_falls_back_to_default_anchor_align_and_anchor_side_if_non_allowed_option_is_set
        without_fetch_or_fallback_raises do
          render_inline Primer::Alpha::ActionMenu.new(menu_id: "menu-1", anchor_side: :inside_out, anchor_align: :upside_down) do |component|
            component.with_show_button { "Trigger" }
            component.with_item(label: "Does something", classes: "do-something-js")
          end
        end

        assert_selector("action-menu[data-anchor-side='outside-bottom'][data-anchor-align='start']", visible: false)
      end

      def test_allows_trigger_button_to_be_icon_button
        render_preview(:with_icon_button)

        assert_selector("action-menu", visible: false) do
          assert_selector("button[aria-haspopup='true']", visible: false) do
            assert_selector("svg", visible: false)
          end

          assert_selector("tool-tip", text: "Menu", visible: false)
        end
      end

      def test_allows_some_tags_as_nested_menu_item
        render_preview(:with_actions)

        assert_selector("action-menu") do
          assert_selector("button[aria-haspopup='true']", text: "Trigger")
          assert_selector("ul", visible: false) do
            assert_selector("li[role='menuitem']", visible: false) do
              assert_selector("button", text: "Does something", visible: false)
            end
            assert_selector("li[role='menuitem']", visible: false) do
              assert_selector("a[href='/']", text: "Site", visible: false)
            end
            assert_selector("li[role='menuitem']", visible: false) do
              assert_selector("clipboard-copy", text: "Copy text", visible: false)
            end
          end
        end
      end

      def test_renders_with_include_fragment_if_src_is_specified
        render_inline Primer::Alpha::ActionMenu.new(menu_id: "deferred-menu", src: "/") do |component|
          component.with_show_button { "Trigger" }
        end

        assert_selector("action-menu") do
          assert_selector("button[id='overlay-show-deferred-menu'][aria-haspopup='true']", text: "Trigger")
          assert_selector("include-fragment[src='/'][data-target='action-menu.includeFragment']", visible: false) do
            assert_selector(".ActionListItem[aria-disabled='true']", visible: false)
          end
        end
      end

      def test_renders_include_fragment_with_preload
        render_inline Primer::Alpha::ActionMenu.new(
          menu_id: "deferred-menu",
          src: "/",
          preload: true,
        ) do |component|
          component.with_show_button { "Trigger" }
        end

        assert_selector("action-menu[preload='true']") do
          assert_selector("button[id='overlay-show-deferred-menu'][aria-haspopup='true']", text: "Trigger")
          assert_selector("include-fragment[src='/'][data-target='action-menu.includeFragment']", visible: false) do
            assert_selector(".ActionListItem[aria-disabled='true']", visible: false)
          end
        end
      end
    end
  end
end
