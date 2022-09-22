# frozen_string_literal: true

module Primer
  module Alpha
    # @label Overlay
    class OverlayPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param role [Symbol] select [dialog, menu]
      # @param popup [Symbol] select [auto,hint,manual]
      # @param width [Symbol] select [auto, small, medium, large, xlarge, xxlarge]
      # @param height [Symbol] select [auto, small, medium, large, xlarge]
      # @param position [Symbol] select [center, left, right]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param button_text [String] text
      # @param body_text [String] text
      # @param header_size [Symbol] select [medium, large]
      def default(title: "Test Overlay", subtitle: nil, role: :dialog, width: :auto, height: :auto, button_text: "Show Overlay", body_text: "Content", visually_hide_title: false, header_size: :medium)
        render(Primer::Alpha::Overlay.new(title: title, subtitle: subtitle, role: role, width: width, height: height, visually_hide_title: visually_hide_title)) do |d|
          d.with_header(title: title, size: header_size)
          d.with_show_button { button_text }
          d.with_body { body_text }
        end
      end
    end
  end
end
