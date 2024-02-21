# frozen_string_literal: true

module Primer
  module Alpha
    # @label LiveRegionAnnouncement
    class LiveRegionAnnouncementPreview < ViewComponent::Preview
      # @label default
      def default
        render(Primer::Alpha::LiveRegionAnnouncement.new)
      end
    end
  end
end
