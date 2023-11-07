# frozen_string_literal: true

require "components/test_helper"

module Primer
  module Alpha
    class ToggleSwitchTest < Minitest::Test
      include ViewComponent::TestHelpers

      def test_default_unchecked
        render_preview(:default)

        assert_selector(".ToggleSwitch")
        refute_selector(".ToggleSwitch--checked")
      end

      def test_default_off_label
        render_preview(:default)

        assert_selector(".ToggleSwitch-status", text: "Off", visible: true)
      end

      def test_checked
        render_preview(:checked)

        assert_selector("toggle-switch.ToggleSwitch--checked")
      end

      def test_checked_on_label
        render_preview(:checked)

        assert_selector(".ToggleSwitch-status", text: "On", visible: true)
      end

      def test_disabled
        render_preview(:disabled)

        assert_selector(".ToggleSwitch--disabled")
      end

      def test_checked_disabled
        render_preview(:checked_disabled)

        assert_selector(".ToggleSwitch--disabled")
        assert_selector(".ToggleSwitch--checked")
      end

      def test_status_label_position
        render_preview(:default)

        refute_selector("toggle-switch.ToggleSwitch--statusAtEnd")
      end

      def test_status_label_position_end
        render_preview(:with_status_label_position_end)

        assert_selector("toggle-switch.ToggleSwitch--statusAtEnd")
      end

      def test_small
        render_preview(:small)

        assert_selector(".ToggleSwitch--small")
      end

      def test_csrf_token
        render_inline(Primer::Alpha::ToggleSwitch.new(src: "/foo", csrf_token: "abc123"))

        assert_selector("[csrf]")
      end
    end
  end
end
