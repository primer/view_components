# frozen_string_literal: true

module Primer
  module OpenProject
    # @label SuccessDialog
    class SuccessDialogPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param heading [String] text
      # @param description [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position [Symbol] select [center, left, right]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param disable_button [Boolean] toggle
      # @param button_text [String] text
      # @param icon [Symbol] octicon
      def playground(heading: "Test Dialog", description: "Some description", size: :medium, button_text: "Show Dialog", position: :center, position_narrow: :fullscreen, visually_hide_title: false, icon: nil, disable_button: false)
        render(Primer::OpenProject::SuccessDialog.new(size: size, position: position, position_narrow: position_narrow, visually_hide_title: visually_hide_title)) do |dialog|
          if icon.present? && (icon != :none)
            dialog.with_show_button(icon: icon, "aria-label": icon.to_s, disabled: disable_button)
          else
            dialog.with_show_button(disabled: disable_button) { button_text }
          end
          dialog.with_success_message do |message|
            message.with_heading(tag: :h2) { heading }
            message.with_description { description }
          end
        end
      end

      # @label With additional content
      #
      # @param heading [String] text
      # @param description [String] text
      # @param additional_content [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position [Symbol] select [center, left, right]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param disable_button [Boolean] toggle
      # @param button_text [String] text
      # @param icon [Symbol] octicon
      def with_additional_content(heading: "Test Dialog", description: "Some description", additional_content: "More content without predefined formatting", size: :medium, button_text: "Show Dialog", position: :center, position_narrow: :fullscreen, visually_hide_title: false, icon: nil, disable_button: false)
        render(Primer::OpenProject::SuccessDialog.new(size: size, position: position, position_narrow: position_narrow, visually_hide_title: visually_hide_title)) do |dialog|
          if icon.present? && (icon != :none)
            dialog.with_show_button(icon: icon, "aria-label": icon.to_s, disabled: disable_button)
          else
            dialog.with_show_button(disabled: disable_button) { button_text }
          end
          dialog.with_success_message do |message|
            message.with_heading(tag: :h2) { heading }
            message.with_description { description }
          end
          dialog.with_additional_content { additional_content }
        end
      end

      # @label With custom icons
      #
      # @param message_icon [String] octicon
      # @param heading [String] text
      # @param description [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position [Symbol] select [center, left, right]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param disable_button [Boolean] toggle
      # @param button_text [String] text
      # @param icon [Symbol] octicon
      def with_custom_icons(message_icon: :rocket, heading: "Test Dialog", description: "Some description", size: :medium, button_text: "Show Dialog", position: :center, position_narrow: :fullscreen, visually_hide_title: false, icon: :telescope, disable_button: false)
        render(Primer::OpenProject::SuccessDialog.new(message_icon: message_icon, size: size, position: position, position_narrow: position_narrow, visually_hide_title: visually_hide_title)) do |dialog|
          if icon.present? && (icon != :none)
            dialog.with_show_button(icon: icon, "aria-label": icon.to_s, disabled: disable_button)
          else
            dialog.with_show_button(disabled: disable_button) { button_text }
          end
          dialog.with_success_message do |message|
            message.with_heading(tag: :h2) { heading }
            message.with_description { description }
          end
        end
      end
    end
  end
end
