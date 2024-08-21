# frozen_string_literal: true

module Primer
  module OpenProject
    # @label ConfirmationMessage
    class ConfirmationMessagePreview < ViewComponent::Preview
      # @label Playground
      #
      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def playground(narrow: false, spacious: false, border: false)
        render Primer::OpenProject::ConfirmationMessage.new(narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_heading(tag: :h2).with_content("Title")
          component.with_description { "Description" }
        end
      end

      # @label With custom icon
      #
      # @param icon [Symbol] Octicon
      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def with_custom_icon(icon: :rocket, narrow: false, spacious: false, border: false)
        render Primer::OpenProject::ConfirmationMessage.new(icon: icon, narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_heading(tag: :h2).with_content("Title")
          component.with_description { "Description" }
        end
      end
    end
  end
end
