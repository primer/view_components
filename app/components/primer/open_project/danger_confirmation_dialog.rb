# frozen_string_literal: true

module Primer
  module OpenProject
    # A pre-configured dialog for destructive/"potentially dangerous" actions
    class DangerConfirmationDialog < Primer::Component
      status :open_project

      # The dialog's ID value.
      #
      attr_reader :dialog_id

      # A confirmation message with some defaults that are necessary for rendering nicely.
      #
      # @param heading [String] the heading for the success message
      # @param description [String] the description for the success message
      # @param icon_arguments [Hash] the system_arguments for the icon
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :confirmation_message, lambda { |icon_arguments: {}, **system_arguments|
        system_arguments[:border] = false

        icon_arguments[:icon] ||= :"alert"
        icon_arguments[:color] ||= :danger

        FeedbackMessage.new(icon_arguments: icon_arguments, **system_arguments)
      }

      # A checkbox that the user is required to check in order to continue with the destructive action.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :confirmation_checkbox, lambda { |**system_arguments|
        system_arguments[:display] ||= :flex
        system_arguments[:align_items] ||= :center
        system_arguments[:justify_content] ||= :center

        checkbox_id = "#{dialog_id}-checkbox"

        Primer::OpenProject::DangerConfirmationDialog::ConfirmationCheckbox.new(checkbox_id: checkbox_id, **system_arguments)
      }

      # Optional additional_details such as grid displaying a list of items to be deleted
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :additional_details, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :div
        system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "DangerConfirmationDialog-additionalDetails"
        )

        system_arguments[:display] ||= :flex
        system_arguments[:align_items] ||= :center
        system_arguments[:justify_content] ||= :center
        system_arguments[:mb] ||= 3

        Primer::BaseComponent.new(**system_arguments)
      }

      # @param form_arguments [Hash] Allows the dialog to submit a form on click.
      # @param id [String] The id of the dialog.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        form_arguments: {},
        id: self.class.generate_id,
        **system_arguments
      )
        form_arguments = deny_tag_argument(**form_arguments)
        @show_form = form_arguments.any?
        @form_wrapper = Primer::ConditionalWrapper.new(condition: @show_form, **form_arguments.merge(tag: "form"))

        @dialog_id = id.to_s

        @system_arguments = system_arguments
        @system_arguments[:id] = @dialog_id
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "DangerConfirmationDialog"
        )

        @dialog = Primer::Alpha::Dialog.new(title: @system_arguments[:title], subtitle: nil, visually_hide_title: true, **@system_arguments)
      end

      delegate :labelledby, :header?, :header, :with_header, :with_header_content,
               :show_button?, :show_button, :with_show_button, :with_show_button_content,
               to: :@dialog

      def show_form?
        @show_form
      end

      def render?
        raise ArgumentError, "DangerConfirmationDialog requires a confirmation_message" unless confirmation_message?
        raise ArgumentError, "DangerConfirmationDialog requires a confirmation_checkbox" unless confirmation_checkbox?

        confirmation_message? && confirmation_checkbox?
      end

      private

      def before_render
        content
      end
    end
  end
end
