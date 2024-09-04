# frozen_string_literal: true

module Primer
  module OpenProject
    # @label FeedbackMessage
    class FeedbackMessagePreview < ViewComponent::Preview
      # @label Default
      # @snapshot
      def default
        render Primer::OpenProject::FeedbackMessage.new do |component|
          component.with_heading(tag: :h2) { "Success" }
          component.with_description { "You successfully created your first FeedbackMessage component" }
        end
      end


      # @label Playground
      #
      # @param icon [Symbol] octicon
      # @param icon_color [Symbol] select [default, muted, subtle, accent, success, attention, severe, danger, open, closed, done, sponsors, on_emphasis, inherit]
      # @param loading_state [Boolean] toggle
      # @param title [String]
      # @param description [String]
      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def playground(icon: "check-circle", icon_color: :success, loading_state: false, title: "Yeah!", description: "Some description below...", narrow: false, spacious: false, border: false)
        render Primer::OpenProject::FeedbackMessage.new(icon_arguments: { icon: icon, color: icon_color}, loading: loading_state, narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_heading(tag: :h2).with_content(title)
          component.with_description { description }
        end
      end

      # @label With custom icon
      def with_custom_icon
        render Primer::OpenProject::FeedbackMessage.new(icon_arguments: { icon: :"op-enterprise-addons", classes: "upsale-colored" }) do |component|
          component.with_heading(tag: :h2) { "You are a hero" }
          component.with_description { "Thanks for supporting an open source project!" }
        end
      end

      # @label With custom color
      def with_custom_color
        render Primer::OpenProject::FeedbackMessage.new(icon_arguments: { icon: :"x-circle", color: :danger }) do |component|
          component.with_heading(tag: :h2) { "Ups, something went wrong" }
          component.with_description { "Please try again or contact your administrator." }
        end
      end

      # @label With loading spinner
      def loading_spinner
        render(Primer::OpenProject::FeedbackMessage.new(loading: true)) do |component|
          component.with_heading(tag: :h2) { "Please wait, your request is being processed." }
        end
      end

      # @label With secondary action
      def secondary_action
        render(Primer::OpenProject::FeedbackMessage.new(loading: true)) do |component|
          component.with_heading(tag: :h2) { "Please wait, your request is being processed." }
          component.with_secondary_action(href: "#").with_content("Skip")
        end
      end
    end
  end
end
