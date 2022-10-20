# frozen_string_literal: true

module Primer
  # @label TimelineItemComponent
  class TimelineItemComponentPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param condensed [Boolean]
    def playground(condensed: false)
      render(Primer::TimelineItemComponent.new(condensed: condensed)) do |component|
        component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "octocat")
        component.with_badge(bg: :success_emphasis, color: :on_emphasis, icon: :check)
        component.with_body { "Success!" }
      end
    end

    # @label Default
    #
    # @param condensed [Boolean]
    def default(condensed: false)
      render(Primer::TimelineItemComponent.new(condensed: condensed)) do |component|
        component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "octocat")
        component.with_badge(bg: :success_emphasis, color: :on_emphasis, icon: :check)
        component.with_body { "Success!" }
      end
    end
  end
end
