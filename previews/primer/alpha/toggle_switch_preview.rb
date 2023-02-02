# frozen_string_literal: true

require_relative "../url_helpers"

module Primer
  module Alpha
    # @label Toggle Switch
    class ToggleSwitchPreview < ViewComponent::Preview
      include ActionView::Helpers::FormTagHelper

      def playground
        render(ToggleSwitch.new(src: UrlHelpers.toggle_switch_index_path))
      end

      def default
        render(ToggleSwitch.new(src: UrlHelpers.toggle_switch_index_path))
      end

      def checked
        render(ToggleSwitch.new(src: UrlHelpers.toggle_switch_index_path, checked: true))
      end

      def disabled
        render(ToggleSwitch.new(src: UrlHelpers.toggle_switch_index_path, enabled: false))
      end

      def checked_disabled
        render(ToggleSwitch.new(src: UrlHelpers.toggle_switch_index_path, checked: true, enabled: false))
      end

      def small
        render(ToggleSwitch.new(src: UrlHelpers.toggle_switch_index_path, size: :small))
      end

      def with_status_label_position_end
        render(ToggleSwitch.new(src: UrlHelpers.toggle_switch_index_path, status_label_position: :end))
      end

      def with_a_bad_src
        render(ToggleSwitch.new(src: "/foo"))
      end

      def with_no_src
        render(ToggleSwitch.new)
      end

      def with_csrf_token
        render(ToggleSwitch.new(src: UrlHelpers.toggle_switch_index_path, csrf_token: "let_me_in"))
      end

      def with_bad_csrf_token
        render(ToggleSwitch.new(src: UrlHelpers.toggle_switch_index_path, csrf_token: "i_am_a_criminal"))
      end
    end
  end
end
