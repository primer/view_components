# frozen_string_literal: true

module Primer
  module OpenProject
    # @label ConfirmationMessage
    class ConfirmationMessagePreview < ViewComponent::Preview
      # @label Default
      # @snapshot
      def default
        render Primer::OpenProject::ConfirmationMessage.new do |component|
          component.with_heading(tag: :h2).with_content("Success")
          component.with_description { "You successfully created your first ConfirmationMessageComponent" }
        end
      end


      # @label Playground
      #
      # @param icon [Symbol] octicon
      # @param icon_color [Symbol] select [default, muted, subtle, accent, success, attention, severe, danger, open, closed, done, sponsors, on_emphasis, inherit]
      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def playground(icon: "check-circle", icon_color: :success, text: "Some description below...", title: "Yeah!", narrow: false, spacious: false, border: false)
        render Primer::OpenProject::ConfirmationMessage.new(icon_arguments: { icon: icon, color: icon_color}, narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_heading(tag: :h2).with_content(title)
          component.with_description { text }
        end
      end

      # @label With custom icon
      def with_custom_icon
        render Primer::OpenProject::ConfirmationMessage.new(icon_arguments: { icon: :"op-enterprise-addons", classes: "upsale-colored" }) do |component|
          component.with_heading(tag: :h2).with_content("You are a hero")
          component.with_description { "Thanks for supporting an open source project!" }
        end
      end

      # @label With custom color
      def with_custom_color
        render Primer::OpenProject::ConfirmationMessage.new(icon_arguments: { icon: :"x-circle", color: :danger }) do |component|
          component.with_heading(tag: :h2).with_content("Ups, something went wrong")
          component.with_description { "Please try again or contact your administrator." }
        end
      end
    end
  end
end
