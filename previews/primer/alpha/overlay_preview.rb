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
      # @param popover [Symbol] select [auto,manual]
      # @param width [Symbol] select [auto, small, medium, large, xlarge, xxlarge]
      # @param height [Symbol] select [auto, small, medium, large, xlarge]
      def default(title: "Test Overlay", subtitle: nil, role: :dialog, popover: :auto, width: :auto, height: :auto, button_text: "Show Overlay", body_text: "Content", visually_hide_title: false, header_size: :medium)
        render(Primer::Alpha::Overlay.new(title: title, subtitle: subtitle, role: role, popover: popover, width: width, height: height, visually_hide_title: visually_hide_title)) do |d|
          d.with_header(title: title, size: header_size)
          d.with_show_button { button_text }
          d.with_body { body_text }
        end
      end
    end
  end
end
