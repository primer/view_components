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

        assert_selector("action-menu") do |menu|
          menu.assert_selector("button[id='menu-1-button'][aria-haspopup='true']", text: "Menu")
          menu.assert_selector("ul[id='menu-1-list'][aria-labelledby='menu-1-button'][role='menu']", visible: false) do |ul|
            ul.assert_selector("li button[role='menuitem']", visible: false)
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

        assert_selector("action-menu", visible: false) do |menu|
          menu.assert_selector("button[aria-haspopup='true']", visible: false) do |button|
            button.assert_selector("svg", visible: false)
          end

          menu.assert_selector("tool-tip", text: "Menu", visible: false)
        end
      end

      def test_allows_some_tags_as_nested_menu_item
        render_preview(:with_actions)

        assert_selector("action-menu") do |menu|
          menu.assert_selector("button[aria-haspopup='true']", text: "Trigger")
          menu.assert_selector("ul", visible: false) do |list|
            list.assert_selector("li button[role='menuitem']", text: "Alert", visible: false)
            list.assert_selector("li a", text: "Navigate", visible: false)
            list.assert_selector("li clipboard-copy[role='menuitem']", text: "Copy text", visible: false)
          end
        end
      end

      def test_renders_with_include_fragment_if_src_is_specified
        render_inline Primer::Alpha::ActionMenu.new(menu_id: "deferred-menu", src: "/") do |component|
          component.with_show_button { "Trigger" }
        end

        assert_selector("action-menu") do |menu|
          menu.assert_selector("button[id='deferred-menu-button'][aria-haspopup='true']", text: "Trigger")
          menu.assert_selector("include-fragment[src='/'][data-target='action-menu.includeFragment']", visible: false) do |fragment|
            fragment.assert_selector(".ActionListItem[aria-disabled='true']", visible: false)
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

        assert_selector("action-menu[preload='true']") do |menu|
          menu.assert_selector("button[id='deferred-menu-button'][aria-haspopup='true']", text: "Trigger")
          menu.assert_selector("include-fragment[src='/'][data-target='action-menu.includeFragment']", visible: false) do |fragment|
            fragment.assert_selector(".ActionListItem[aria-disabled='true']", visible: false)
          end
        end
      end

      def test_disabled
        render_preview(:with_disabled_items)

        assert_selector("li[role='none'] button.ActionListContent[aria-disabled=true]", text: "Does something")
        assert_selector("li[role='none'] a.ActionListContent[aria-disabled=true]", text: "Site")
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

      def test_avatar_items_appear_in_sub_menus
        render_preview(:multiple_select, params: { nest_in_sub_menu: true })

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

      def test_renders_groups_in_sub_menu
        render_preview(:with_groups, params: { nest_in_sub_menu: true })

        assert_selector("ul[role=menu] ul[role=menu]") do |menu|
          menu.assert_selector(".ActionList-sectionDivider .ActionList-sectionDivider-title", count: 3)
          menu.assert_selector("ul[role=group]", count: 3) do |group|
            group.assert_selector("li[role=none]") do |item|
              item.assert_selector "button[role=menuitem]"
            end
          end
        end
      end

      def test_renders_sub_menus_in_sub_menus
        render_inline Primer::Alpha::ActionMenu.new(menu_id: "foo") do |component|
          component.with_show_button { "Trigger" }
          component.with_sub_menu_item(label: "Level 2") do |level2|
            level2.with_sub_menu_item(label: "Level 3") do |level3|
              level3.with_item(label: "Level 4")
            end
          end
        end

        assert_selector("[role=menu]") do |level1|
          level1.assert_selector("[role='menuitem']", text: "Level 2")
          level1.assert_selector("[role=menu]") do |level2|
            level2.assert_selector("[role=menuitem]", text: "Level 3")
            level2.assert_selector("[role=menu]") do |level3|
              level3.assert_selector("[role=menuitem]", text: "Level 4")
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

      def test_does_not_double_render_show_button_content
        render_inline_erb(<<~ERB)
          <%= render(Primer::Alpha::ActionMenu.new) do |menu| %>
            <% menu.with_show_button(scheme: :invisible) do |button| %>
              test
            <% end %>
            <% menu.with_item { "an account" } %>
          <% end %>
        ERB

        assert @rendered_content.scan("test").size == 1, "The show button rendered its content more than once"
      end

      def test_single_select_form_items_have_role_none
        render_preview(:single_select_form_items)

        # one form per item
        assert_selector "form[role=none]", count: 2
      end

      def test_forwards_overlay_arguments
        render_inline(Primer::Alpha::ActionMenu.new(menu_id: "foo", overlay_arguments: { data: { foo: "bar" } })) do |menu|
          menu.with_item { "foo" }
        end

        assert_selector "anchored-position[data-foo=bar]"
      end

      def test_renders_submenus
        render_preview(:with_actions, params: { nest_in_sub_menu: true })

        assert_selector("action-menu") do |menu|
          sub_menu_button = page.find_css("li button", text: "Sub-menu").first
          popover_id = sub_menu_button["popovertarget"]

          menu.assert_selector("anchored-position##{popover_id} ul", visible: false) do |sub_menu|
            sub_menu.assert_selector("li button[role='menuitem']", text: "Alert", visible: false)
            sub_menu.assert_selector("li a", text: "Navigate", visible: false)
            sub_menu.assert_selector("li clipboard-copy[role='menuitem']", text: "Copy text", visible: false)
          end
        end
      end

      def test_renders_internal_label
        render_preview(:single_select_with_internal_label)

        assert_selector("button[aria-haspopup='true'] .Button-label", text: "Menu")
      end
    end
  end
end
