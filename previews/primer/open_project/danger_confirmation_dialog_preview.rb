# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label DangerConfirmationDialog
    class DangerConfirmationDialogPreview < ViewComponent::Preview
      # @label Default
      # @snapshot interactive
      def default
        render(Primer::OpenProject::DangerConfirmationDialog.new(title: "Delete dialog")) do |dialog|
          dialog.with_show_button { "Click me" }
          dialog.with_confirmation_message do |message|
            message.with_heading(tag: :h2) { "Permanently delete?" }
            message.with_description_content("This action is not reversible. Please proceed with caution.")
          end
          dialog.with_confirmation_check_box_content("I understand that this deletion cannot be reversed")
        end
      end

      # @label Playground
      # @param icon [Symbol] octicon
      # @param icon_color [Symbol] select [default, muted, subtle, accent, success, attention, severe, danger, open, closed, done, sponsors, on_emphasis, inherit]
      # @param show_description toggle
      # @param show_additional_details toggle
      # @param check_box_text [String]
      def playground(
        icon: :"alert",
        icon_color: :danger,
        show_description: true,
        show_additional_details: false,
        check_box_text: "I understand that this deletion cannot be reversed"
      )
        render_with_template(locals: { icon: icon,
                                       icon_color: icon_color,
                                       show_description: show_description,
                                       show_additional_details: show_additional_details,
                                       check_box_text: check_box_text })
      end

      # @label With form
      def with_form(route_format: :html)
        render(Primer::OpenProject::DangerConfirmationDialog.new(
          title: "Delete dialog",
          form_arguments: {
            method: :post,
            action: generic_form_submission_path(format: route_format),
            novalidate: true
          }
        )) do |dialog|
          dialog.with_show_button { "Click me" }
          dialog.with_confirmation_message do |message|
            message.with_heading(tag: :h2).with_content("Permanently delete?")
            message.with_description_content("This action is not reversible. Please proceed with caution.")
          end
          dialog.with_confirmation_check_box_content("I understand that this deletion cannot be reversed")
        end
      end

      # @label With additional details
      def with_additional_details
        render_with_template(locals: {})
      end

      # @label With custom icon
      def custom_icon
        render(Primer::OpenProject::DangerConfirmationDialog.new(title: "Delete dialog")) do |dialog|
          dialog.with_show_button { "Click me" }
          dialog.with_confirmation_message(icon_arguments: { icon: :"alert-fill" }) do |message|
            message.with_heading(tag: :h2) { "Permanently delete?" }
            message.with_description_content("This action is not reversible and will remove all containing sub-tiems. Please proceed with caution.")
          end
          dialog.with_confirmation_check_box_content("I understand that this deletion cannot be reversed")
        end
      end
    end
  end
end
