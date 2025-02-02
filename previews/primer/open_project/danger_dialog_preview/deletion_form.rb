# frozen_string_literal: true
module Primer
  module OpenProject
    class DangerDialogPreview
      # :nodoc:
      class DeletionForm < Primer::Forms::Base
        form do |deletion_form|
          deletion_form.text_field(
            name: :reason,
            label: "Reason for deletion",
            required: true,
            caption: "Enter the reason for deleting this item"
          )
          deletion_form.check_box_group(name: "notify", label: "Notify") do |check_group|
            check_group.check_box(value: "creator", label: "Creator")
            check_group.check_box(value: "assignee", label: "Assignee")
            check_group.check_box(value: "watchers", label: "Watchers")
          end
        end
      end
    end
  end
end
