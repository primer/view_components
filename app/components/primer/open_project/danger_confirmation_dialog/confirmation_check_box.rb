# frozen_string_literal: true

module Primer
  module OpenProject
    class DangerConfirmationDialog
      # This component is part of `Primer::OpenProject::DangerConfirmationDialog`
      # and should not be used as a standalone component.
      class ConfirmationCheckBox < Primer::Component

        # @param check_box_id [String] The id of the check_box input.
        # @param check_box_name [String] The name of the check_box input.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(check_box_id: self.class.generate_id, check_box_name:, **system_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div
          @system_arguments[:classes] = class_names(
            system_arguments[:classes],
            "DangerConfirmationDialog-confirmationCheckBox"
          )

          @check_box_arguments = {}
          @check_box_arguments[:id] = check_box_id
          @check_box_arguments[:name] = check_box_name
          @check_box_arguments[:data] = {
            target: "danger-confirmation-dialog-form-helper.checkbox",
            action: "change:danger-confirmation-dialog-form-helper#toggle"
          }
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) do
            render(Primer::Alpha::CheckBox.new(**@check_box_arguments.merge(label: trimmed_content)))
          end
        end

        def render?
          raise ArgumentError, "ConfirmationCheckBox requires a content block" unless trimmed_content.present?

          true
        end
      end
    end
  end
end
