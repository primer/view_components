# frozen_string_literal: true

module Primer
  module Alpha
    # @label FormControl
    class FormControlPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param label text
      # @param caption text
      # @param validation_message text
      # @param required toggle
      # @param visually_hide_label toggle
      # @param full_width toggle
      def playground(
        label: "Best character",
        caption: "May the force be with you",
        validation_message: "Something went wrong",
        required: false,
        visually_hide_label: false,
        full_width: false
      )
        render_with_template(
          locals: {
            system_arguments: {
              label: label,
              caption: caption,
              validation_message: validation_message,
              required: required,
              visually_hide_label: visually_hide_label,
              full_width: full_width
            }
          }
        )
      end

      # @label Default
      def default
        render_with_template(
          template: "primer/alpha/form_control_preview/playground",
          locals: {
            system_arguments: {
              label: "Best character"
            }
          }
        )
      end

      # @!group Options
      #
      # @label With caption
      def with_caption
        render_with_template(
          template: "primer/alpha/form_control_preview/playground",
          locals: {
            system_arguments: {
              label: "Best character",
              caption: "May the force be with you"
            }
          }
        )
      end

      # @label With validation message
      def with_validation_message
        render_with_template(
          template: "primer/alpha/form_control_preview/playground",
          locals: {
            system_arguments: {
              label: "Best character",
              validation_message: "Something went wrong"
            }
          }
        )
      end

      # @label Required
      def required
        render_with_template(
          template: "primer/alpha/form_control_preview/playground",
          locals: {
            system_arguments: {
              label: "Best character",
              required: true
            }
          }
        )
      end

      # @label With visually hidden label
      def with_visually_hidden_label
        render_with_template(
          template: "primer/alpha/form_control_preview/playground",
          locals: {
            system_arguments: {
              label: "Best character",
              visually_hide_label: true
            }
          }
        )
      end
      #
      # @!endgroup
    end
  end
end
