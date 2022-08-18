# frozen_string_literal: true

module Primer
  module Alpha
    class ToggleSwitchPreview < ViewComponent::Preview
      include ActionView::Helpers::FormTagHelper

      def default
        render(ToggleSwitch.new(src: "/primer/toggle_switch"))
      end

      def checked
        render(ToggleSwitch.new(src: "/primer/toggle_switch", checked: true))
      end

      def disabled
        render(ToggleSwitch.new(src: "/primer/toggle_switch", enabled: false))
      end

      def checked_disabled
        render(ToggleSwitch.new(src: "/primer/toggle_switch", checked: true, enabled: false))
      end

      def small
        render(ToggleSwitch.new(src: "/primer/toggle_switch", size: :small))
      end

      def with_status_label_position_end
        render(ToggleSwitch.new(src: "/primer/toggle_switch", status_label_position: :end))
      end

      def with_a_bad_src
        render(ToggleSwitch.new(src: "/foo"))
      end
    end
  end
end
