# frozen_string_literal: true

require "components/test_helper"

module Primer
  module Alpha
    class ActionMenuTest < Minitest::Test
      include Primer::ComponentTestHelpers

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
          assert_selector("button[id='menu-1-button'][aria-haspopup='true']", text: "Menu")
          assert_selector("ul[id='menu-1-list'][aria-labelledby='menu-1-button'][role='menu']", visible: false) do
            assert_selector("li button[role='menuitem']", visible: false)
          end
        end
      end

      def test_falls_back_to_button_if_disallowed_tag_is_given
        without_fetch_or_fallback_raises do
          render_inline Primer::Alpha::ActionMenu.new(menu_id: "bad-menu") do |component|
            component.with_show_button { "Trigger" }
            component.with_item(tag: :details, label: "Does something", onclick: "() => {console.log('hey')}")
          end
        end

        assert_selector("button.ActionListContent", visible: false)
      end

      def test_falls_back_to_default_anchor_align_and_anchor_side_if_non_allowed_option_is_set
        without_fetch_or_fallback_raises do
          render_inline Primer::Alpha::ActionMenu.new(menu_id: "menu-1", anchor_side: :inside_out, anchor_align: :upside_down) do |component|
            component.with_show_button { "Trigger" }
            component.with_item(label: "Does something", classes: "do-something-js")
          end
        end

        assert_selector("anchored-position[side='outside-bottom'][align='start']", visible: false)
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
            assert_selector("li", visible: false) do
              assert_selector("button[role='menuitem']", text: "Alert", visible: false)
            end
            assert_selector("li", visible: false) do
              assert_selector("a", text: "Navigate", visible: false)
            end
            assert_selector("li", visible: false) do
              assert_selector("clipboard-copy[role='menuitem']", text: "Copy text", visible: false)
            end
          end
        end
      end

      def test_renders_with_include_fragment_if_src_is_specified
        render_inline Primer::Alpha::ActionMenu.new(menu_id: "deferred-menu", src: "/") do |component|
          component.with_show_button { "Trigger" }
        end

        assert_selector("action-menu") do
          assert_selector("button[id='deferred-menu-button'][aria-haspopup='true']", text: "Trigger")
          assert_selector("include-fragment[src='/'][data-target='action-menu.includeFragment']", visible: false) do
            assert_selector(".ActionListItem[aria-disabled='true']", visible: false)
          end
        end
      end

      def test_renders_include_fragment_with_preload
        render_inline Primer::Alpha::ActionMenu.new(
          menu_id: "deferred-menu",
          src: "/",
          preload: true
        ) do |component|
          component.with_show_button { "Trigger" }
        end

        assert_selector("action-menu[preload='true']") do
          assert_selector("button[id='deferred-menu-button'][aria-haspopup='true']", text: "Trigger")
          assert_selector("include-fragment[src='/'][data-target='action-menu.includeFragment']", visible: false) do
            assert_selector(".ActionListItem[aria-disabled='true']", visible: false)
          end
        end
      end

      def test_disabled
        render_preview(:with_disabled_items)

        assert_selector("li[aria-disabled=true]") do
          assert_selector("button.ActionListContent[aria-disabled=true]", text: "Does something")
          assert_selector("a.ActionListContent[aria-disabled=true]", text: "Site")
        end
      end

      def test_renders_a_tag_when_href_provided
        render_preview(:links)

        assert_selector("li a[href='/']", text: "Settings")
        assert_selector("li a[href='/']", text: "Your repositories")
        assert_selector("li button[aria-disabled=true]", text: "Disabled")
      end

      def test_content_labels_render_correctly
        render_preview(:content_labels)

        assert_selector "li span.copy-link"
        assert_selector "li span.quote-reply"
      end

      def test_avatar_options_are_passed_through
        render_preview(:multiple_select)

        assert_selector ".ActionListItem .avatar"
        refute_selector ".ActionListItem .avatar.circle"
      end

      def test_renders_groups
        render_preview(:with_groups)

        assert_selector("ul[role=menu]") do |menu|
          menu.assert_selector(".ActionList-sectionDivider .ActionList-sectionDivider-title", count: 3)
          menu.assert_selector("ul[role=group]", count: 3) do |group|
            group.assert_selector("li[role=none]") do |item|
              item.assert_selector "button[role=menuitem]"
            end
          end
        end
      end

      def test_renders_individual_items_inside_groups_when_at_least_one_group
        render_preview(:with_items_and_groups)

        assert_selector("ul[role=menu]") do |menu|
          menu.assert_selector("ul[role=group]", count: 3) do |group|
            group.assert_selector("li[role=none]") do |item|
              item.assert_selector "button[role=menuitem]"
            end
          end
        end
      end

      def test_groups_cannot_have_dividers
        err = assert_raises RuntimeError do
          render_inline(Primer::Alpha::ActionMenu.new(menu_id: "foo")) do |menu|
            menu.with_group(&:with_divider)
          end
        end

        assert_equal "ActionMenu groups cannot have dividers", err.message
      end
    end
  end
end
