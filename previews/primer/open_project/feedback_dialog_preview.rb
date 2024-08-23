# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label FeedbackDialog
    class FeedbackDialogPreview < ViewComponent::Preview
      # @label Default
      # @snapshot
      def default
        render(Primer::OpenProject::FeedbackDialog.new) do |dialog|
          dialog.with_show_button { "Click me" }
          dialog.with_feedback_message do |message|
            message.with_heading(tag: :h2).with_content("Success")
            message.with_description { "Great! Everything worked well." }
          end
        end
      end

      # @label Playground
      def playground
        # ToDo
      end

      # @label With additional content
      def additional_content
        render_with_template(locals: {})
      end

      # @label With custom icon
      def custom_icon
        render(Primer::OpenProject::FeedbackDialog.new) do |dialog|
          dialog.with_show_button { "Click me" }
          dialog.with_feedback_message(icon_arguments: { icon: :"x-circle", color: :danger }) do |message|
            message.with_heading(tag: :h2).with_content("Ups, something went wrong")
            message.with_description { "Please try again or contact your administrator if the issue persists." }
          end
        end
      end

      # @label With custom footer
      def custom_footer
        # ToDo
      end
    end
  end
end
