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
        render_inline(Primer::Alpha::SelectPanel.new(show_filter: false))

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

      def test_renders_custom_preload_error_content
        render_inline(Primer::Alpha::SelectPanel.new(fetch_strategy: :eventually_local, src: "/foo")) do |panel|
          panel.with_preload_error_content { "Foobar" }
        end

        banner_element = page.find_css("select-panel [data-target='select-panel.fragmentErrorElement']")
        assert_includes banner_element.text, "Foobar"
      end

      def test_renders_custom_error_content
        render_inline(Primer::Alpha::SelectPanel.new) do |panel|
          panel.with_error_content { "Foobar" }
        end

        banner_element = page.find_css("select-panel [data-target='select-panel.bannerErrorElement']").first
        assert_includes banner_element.text, "Foobar"
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

      def test_renders_close_button
        render_preview(:default)

        panel_id = page.find_css("select-panel").first.attributes["id"].value
        assert_selector "select-panel button[data-close-dialog-id='#{panel_id}-dialog']"
      end
    end
  end
end
