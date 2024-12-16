# frozen_string_literal: true

module Primer
  module OpenProject
    class DangerConfirmationDialog
      # This component is part of `Primer::OpenProject::DangerConfirmationDialog`
      # and should not be used as a standalone component.
      class ConfirmationCheckbox < Primer::Component

        # @param checkbox_id [String] The id of the checkbox input.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(checkbox_id: self.class.generate_id, **system_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div
          @system_arguments[:classes] = class_names(
            system_arguments[:classes],
            "DangerConfirmationDialog-confirmationCheckbox"
          )

          @checkbox_arguments = {}
          @checkbox_arguments[:id] = checkbox_id
          @checkbox_arguments[:name] = "confirm_dangerous_action"
          @checkbox_arguments[:data] = {
            target: "danger-confirmation-dialog-form-helper.checkbox",
            action: "change:danger-confirmation-dialog-form-helper#toggle"
          }
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) do
            render(Primer::Alpha::CheckBox.new(**@checkbox_arguments.merge(label: trimmed_content)))
          end
        end
      end
    end
  end
end
