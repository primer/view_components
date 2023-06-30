# frozen_string_literal: true

module Primer
  module Alpha
    # @label MultiInput
    class MultiInputPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param label text
      # @param caption text
      # @param disabled toggle
      def playground(
        label: "Dietary preference",
        caption: "What'll ya have?",
        disabled: false
      )
        render_with_template(
          locals: {
            system_arguments: {
              label: label,
              caption: caption,
              disabled: disabled
            }
          }
        )
      end

      # @label Default
      # @snapshot
      def default
        render_with_template(
          template: "primer/alpha/multi_input_preview/playground",
          locals: {
            system_arguments: {
              label: "Dietary preference"
            }
          }
        )
      end

      # @label With caption
      # @snapshot
      def with_caption
        render_with_template(
          template: "primer/alpha/multi_input_preview/playground",
          locals: {
            system_arguments: {
              label: "Dietary preference",
              caption: "What'll ya have?"
            }
          }
        )
      end

      # @label Visually hidden label
      # @snapshot
      def visually_hide_label
        render_with_template(
          template: "primer/alpha/multi_input_preview/playground",
          locals: {
            system_arguments: {
              label: "Dietary preference",
              visually_hide_label: true
            }
          }
        )
      end

      # @label Disabled
      # @snapshot
      def disabled
        render_with_template(
          template: "primer/alpha/multi_input_preview/playground",
          locals: {
            system_arguments: {
              label: "Dietary preference",
              disabled: true
            }
          }
        )
      end
    end
  end
end
