# frozen_string_literal: true

require_relative "../url_helpers"

module Primer
  module Alpha
    # @label Toggle Switch
    class ToggleSwitchPreview < ViewComponent::Preview
      include ActionView::Helpers::FormTagHelper

      def playground
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, "aria-label": "Toggle Switch"))
      end

      # @snapshot
      def default
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, "aria-label": "Default Toggle Switch"))
      end

      # @snapshot
      def checked
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, checked: true, "aria-label": "Checked Toggle Switch"))
      end

      # @snapshot
      def disabled
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, enabled: false, "aria-label": "Disabled Toggle Switch"))
      end

      # @snapshot
      def checked_disabled
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, checked: true, enabled: false, "aria-label": "Checked Disabled Toggle Switch"))
      end

      # @snapshot
      def small
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, size: :small, "aria-label": "Small Toggle Switch"))
      end

      # @snapshot
      def with_status_label_position_end
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, status_label_position: :end, "aria-label": "Toggle Switch with Status"))
      end

      # @snapshot
      def with_a_bad_src
        render(Primer::Alpha::ToggleSwitch.new(src: "/foo", "aria-label": "Toggle Switch"))
      end

      def with_no_src
        render(Primer::Alpha::ToggleSwitch.new("aria-label": "Toggle Switch"))
      end

      def with_csrf_token
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, "aria-label": "Toggle Switch"))
      end

      def with_bad_csrf_token
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, csrf_token: "i_am_a_criminal", "aria-label": "Toggle Switch"))
      end

      def with_turbo
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, turbo: true, "aria-label": "Toggle Switch"))
      end

      def with_autofocus
        render(Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, autofocus: true, "aria-label": "Toggle Switch"))
      end
    end

    def with_custom_status_label
      render Primer::Alpha::ToggleSwitch.new(src: UrlHelpers.primer_view_components.toggle_switch_index_path, on_label: "Enabled", off_label: "Disabled", "aria-label": "Toggle Switch")
    end
  end
end
