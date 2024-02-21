# frozen_string_literal: true

module Primer
  module Alpha
    # @label LiveRegionAnnouncement
    class LiveRegionAnnouncementPreview < ViewComponent::Preview
      # @label default
      def default
        render(Primer::Alpha::LiveRegionAnnouncement.new)
      end

      # @label With button to announce
      def with_button_to_announce
        render_with_template
      end
    end
  end
end
