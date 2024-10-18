# frozen_string_literal: true

require "components/test_helper"

module Primer
  module Alpha
    class SelectPanelTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_renders_a_filter_input
        render_preview(:default)

        assert_selector("select-panel") do
          assert_selector(".Overlay-headerFilter") do
            assert_selector("primer-text-field")
          end
        end
      end

      def test_does_not_render_a_filter_input
        render_inline(Primer::Alpha::SelectPanel.new(fetch_strategy: :local, show_filter: false))

        refute_selector("primer-text-field")
      end

      def test_includes_experimental_param_in_src
        render_preview(:remote_fetch)

        src = page.find_css("select-panel remote-input").first.attributes["src"].value
        uri = URI(src)

        assert_includes uri.query.split("&"), "experimental=1"
      end

      def test_filter_input_owns_body
        render_preview(:remote_fetch)

        panel_id = page.find_css("select-panel").first.attributes["id"].value
        assert_selector "remote-input[aria-owns='#{panel_id}-body']"
      end

      def test_renders_title
        render_preview(:playground)
        assert_selector "select-panel .Overlay-title", text: "Menu"
      end

      def test_renders_subtitle
        render_preview(:playground)
        assert_selector "select-panel .Overlay-description", text: "Various tools from your favorite shows"
      end

      def test_renders_footer
        render_preview(:default)
        assert_selector "select-panel .Overlay-footer", text: "I'm a footer!"
      end

      def test_invoker_controls_dialog
        render_preview(:default)

        panel_id = page.find_css("select-panel").first.attributes["id"].value
        assert_selector "select-panel button[id='#{panel_id}-button'][aria-controls='#{panel_id}-dialog']"
        assert_selector "select-panel dialog[id='#{panel_id}-dialog']"
      end

      def test_list_role
        render_preview(:default)

        panel_id = page.find_css("select-panel").first.attributes["id"].value
        assert_selector "select-panel action-list ul[id='#{panel_id}-list'][role=listbox]"
      end

      def test_aria_labelledby_dialog
        render_preview(:default)

        dialog_labelledby_id = page.find_css("dialog").first.attributes["aria-labelledby"].value
        header_id = page.find_css("select-panel h1").first.attributes["id"].value
        assert_equal dialog_labelledby_id, header_id
      end

      def test_custom_loading_label
        render_preview(:custom_loading_label)

        # Check that there's a loading label, but no description
        assert_selector "svg[aria-label='Custom loading content... please wait...']"
        refute_selector "svg[aria-label='Custom loading content... please wait...'][aria-describedby='select-panel-loading-description']"
      end

      def test_custom_loading_description
        render_preview(:custom_loading_description)

        # Check that there's a loading label and description
        assert_selector "svg[aria-label='Custom loading content... please wait...'][aria-describedby='select-panel-loading-description']"
        assert_selector "div", text: "This is a custom loading description", id: "select-panel-loading-description"
      end

      def test_renders_close_button
        render_preview(:default)

        panel_id = page.find_css("select-panel").first.attributes["id"].value
        assert_selector "select-panel button[data-close-dialog-id='#{panel_id}-dialog']"
      end

      def test_raises_if_remote_strategy_and_hidden_filter_used_together
        with_raise_on_invalid_options(true) do
          error = assert_raises do
            render_inline(Primer::Alpha::SelectPanel.new(fetch_strategy: :remote, show_filter: false))
          end

          assert_includes error.message, "Hiding the filter input with a remote fetch strategy is not permitted"
        end
      end

      def test_raises_if_role_given
        with_raise_on_invalid_options(true) do
          error = assert_raises do
            render_inline(Primer::Alpha::SelectPanel.new(role: :listbox))
          end

          assert_includes error.message, "Please avoid passing the `role:` argument"
        end
      end

      def test_raises_if_role_given_to_item_slot
        with_raise_on_invalid_options(true) do
          error = assert_raises do
            render_inline(Primer::Alpha::SelectPanel.new) do |panel|
              panel.with_item(role: :option)
            end
          end

          assert_includes error.message, "Please avoid passing the `role:` argument"
        end
      end

      def test_does_not_raise_if_no_role_given_to_item_slot
        render_inline(Primer::Alpha::SelectPanel.new) do |panel|
          panel.with_item(label: "Foo")
        end

        assert_selector "select-panel"
      end

      def test_raises_if_role_given_to_avatar_item_slot
        with_raise_on_invalid_options(true) do
          error = assert_raises do
            render_inline(Primer::Alpha::SelectPanel.new) do |panel|
              panel.with_avatar_item(src: "camertron.jpg", username: "camertron", role: :option)
            end
          end

          assert_includes error.message, "Please avoid passing the `role:` argument"
        end
      end

      def test_does_not_raise_if_role_not_given_to_avatar_item_slot
        render_inline(Primer::Alpha::SelectPanel.new) do |panel|
          panel.with_avatar_item(src: "camertron.jpg", username: "camertron")
        end

        assert_selector(".avatar-small")
      end

      def test_renders_default_body_error
        render_inline(Primer::Alpha::SelectPanel.new(src: "/foo"))

        assert_selector "select-panel [data-target='select-panel.bodyErrorMessage']", visible: :hidden do |message_el|
          message_el.assert_selector "h2", text: "Sorry, something went wrong.", visible: :hidden
          message_el.assert_selector "h3", text: "Try again or if the problem persists, contact support.", visible: :hidden
        end
      end

      def test_renders_custom_body_error
        render_inline(Primer::Alpha::SelectPanel.new(src: "/foo")) do |panel|
          panel.with_body_error_message do |message|
            message.with_title { "Foobar" }
            message.with_description { "Barbaz" }
          end
        end

        assert_selector "select-panel [data-target='select-panel.bodyErrorMessage']", visible: :hidden do |message_el|
          message_el.assert_selector "h2", text: "Foobar", visible: :hidden
          message_el.assert_selector "h3", text: "Barbaz", visible: :hidden
        end
      end

      def test_renders_default_banner_error
        render_inline(Primer::Alpha::SelectPanel.new(src: "/foo"))

        assert_selector "select-panel [data-target='select-panel.bannerErrorMessage']", visible: :hidden do |message_el|
          message_el.assert_selector ".Banner", text: "Sorry, something went wrong.", visible: :hidden
        end
      end

      def test_renders_custom_banner_error
        render_inline(Primer::Alpha::SelectPanel.new(src: "/foo")) do |panel|
          panel.with_banner_error_message { "Foobarbazboo" }
        end

        assert_selector "select-panel [data-target='select-panel.bannerErrorMessage']", visible: :hidden do |message_el|
          message_el.assert_selector ".Banner", text: "Foobarbazboo", visible: :hidden
        end
      end

      def test_renders_default_no_items_message
        render_inline(Primer::Alpha::SelectPanel.new(src: "/foo"))

        assert_selector "select-panel [data-target='select-panel.noItemsMessage']", visible: :hidden do |message_el|
          message_el.assert_selector "h2", text: "No items found.", visible: :hidden
        end
      end

      def test_renders_custom_no_items_message
        render_inline(Primer::Alpha::SelectPanel.new(src: "/foo")) do |panel|
          panel.with_no_items_message do |message|
            message.with_title { "Foobar" }
            message.with_description { "Barbaz" }
          end
        end

        assert_selector "select-panel [data-target='select-panel.noItemsMessage']", visible: :hidden do |message_el|
          message_el.assert_selector "h2", text: "Foobar", visible: :hidden
          message_el.assert_selector "h3", text: "Barbaz", visible: :hidden
        end
      end

      def test_renders_default_no_matches_message
        render_inline(Primer::Alpha::SelectPanel.new(src: "/foo"))

        assert_selector "select-panel [data-target='select-panel.noMatchesMessage']", visible: :hidden do |message_el|
          message_el.assert_selector "h2", text: "No matches found.", visible: :hidden
          message_el.assert_selector "h3", text: "Try adjusting your search terms.", visible: :hidden
        end
      end

      def test_renders_custom_no_matches_message
        render_inline(Primer::Alpha::SelectPanel.new(src: "/foo")) do |panel|
          panel.with_no_matches_message do |message|
            message.with_title { "Foobar" }
            message.with_description { "Barbaz" }
          end
        end

        assert_selector "select-panel [data-target='select-panel.noMatchesMessage']", visible: :hidden do |message_el|
          message_el.assert_selector "h2", text: "Foobar", visible: :hidden
          message_el.assert_selector "h3", text: "Barbaz", visible: :hidden
        end
      end
    end
  end
end
