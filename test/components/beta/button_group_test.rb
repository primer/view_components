# frozen_string_literal: true

require "components/test_helper"

module Primer
  module Beta
    class ButtonGroupTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_does_not_render_without_buttons
        render_inline(Primer::Beta::ButtonGroup.new)

        refute_selector("div.ButtonGroup")
      end

      def test_renders_button_items
        render_inline(Primer::Beta::ButtonGroup.new(scheme: :default)) { |component| component.with_button { "Button" } }

        assert_selector("div.ButtonGroup") do
          assert_selector("button.Button--secondary.Button", text: "Button")
        end
      end

      def test_renders_clipboard_copy_button
        render_preview(:with_clipboard_copy_button)

        assert_selector "clipboard-copy[type=button]"
      end

      def test_renders_button_with_props
        render_inline(Primer::Beta::ButtonGroup.new(scheme: :default)) do |component|
          component.with_button { "Button" }
          component.with_button(classes: "custom-class") { "Custom class" }
        end

        assert_selector("div.ButtonGroup") do
          assert_selector("button.Button--secondary.Button", text: "Button")
          assert_selector("button.custom-class", text: "Custom class")
        end
      end

      def test_does_not_render_content
        render_inline(Primer::Beta::ButtonGroup.new) { "content" }

        refute_text("content")
      end

      def test_all_buttons_with_same_size
        render_inline(Primer::Beta::ButtonGroup.new(size: :small)) do |component|
          component.with_button(size: :medium) { "Medium" }
          component.with_button(size: :large) { "Large" }
        end

        assert_selector("div.ButtonGroup") do
          assert_selector("button.Button--small.Button", text: "Medium")
          assert_selector("button.Button--small.Button", text: "Large")
        end
      end

      def test_all_buttons_with_same_scheme
        render_inline(Primer::Beta::ButtonGroup.new(scheme: :primary)) do |component|
          component.with_button(scheme: :primary) { "Primary" }
          component.with_button(scheme: :danger) { "Danger" }
        end

        assert_selector("div.ButtonGroup") do
          assert_selector("button.Button--primary.Button", text: "Primary")
          assert_selector("button.Button--primary.Button", text: "Danger")
        end
      end

      def test_button_with_icon_button
        render_inline(Primer::Beta::ButtonGroup.new) do |component|
          component.with_button { "Button" }
          component.with_button(icon: :star, "aria-label": "Icon button")
        end

        assert_selector("div.ButtonGroup") do
          assert_selector("button.Button", text: "Button")
          assert_selector(".octicon.octicon-star")
        end
      end

      def test_menu_button
        render_preview(:with_menu_button)

        assert_selector("action-menu") do |menu|
          menu.assert_selector("li[data-item-id=item1]", text: "Item 1")
          menu.assert_selector("li[data-item-id=item2]", text: "Item 2")
        end
      end
    end
  end
end
