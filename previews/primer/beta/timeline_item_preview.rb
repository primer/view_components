# frozen_string_literal: true

module Primer
  module Beta
    # @label TimelineItem
    class TimelineItemPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param condensed [Boolean]
      def playground(condensed: false)
        render(Primer::Beta::TimelineItem.new(condensed: condensed)) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "octocat")
          component.with_badge(bg: :success_emphasis, color: :on_emphasis, icon: :check)
          component.with_body { "Success!" }
        end
      end

      # @label Default
      #
      # @param condensed [Boolean]
      # @snapshot
      def default(condensed: false)
        render(Primer::Beta::TimelineItem.new(condensed: condensed)) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "octocat")
          component.with_badge(bg: :success_emphasis, color: :on_emphasis, icon: :check)
          component.with_body { "Success!" }
        end
      end
    end
  end
end
