# frozen_string_literal: true

module Primer
  module OpenProject
    # A pre-configured dialog for destructive/"potentially dangerous" actions
    class DangerDialog < Primer::Component
      status :open_project

      # The dialog's ID value.
      #
      attr_reader :dialog_id

      # A confirmation message with some defaults that are necessary for rendering nicely.
      #
      # To render the message heading (required), call the `with_heading` method, which accepts a `:tag` argument, along with the arguments accepted by <%= link_to_component(Primer::Beta::Heading) %>.
      #
      # To render the message description, call the `with_description` method, which accepts <%= link_to_system_arguments_docs %>
      #
      # @param icon_arguments [Hash] the system_arguments for the icon
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :confirmation_message, lambda { |icon_arguments: {}, **system_arguments|
        system_arguments[:border] = false

        icon_arguments[:icon] ||= :"alert"
        icon_arguments[:color] ||= :danger

        FeedbackMessage.new(icon_arguments: icon_arguments, **system_arguments)
      }

      # An optional checkbox that the user is required to check in order to continue with the destructive action.
      #
      # To render the checkbox label (required), pass a block that returns a String.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :confirmation_check_box, lambda { |**system_arguments|
        system_arguments[:display] ||= :flex
        system_arguments[:align_items] ||= :center
        system_arguments[:justify_content] ||= :center

        check_box_id = "#{dialog_id}-check_box"

        Primer::OpenProject::DangerDialog::ConfirmationCheckBox.new(check_box_id: check_box_id, check_box_name: @check_box_name, **system_arguments)
      }

      # Optional additional details, such as grid displaying a list of items to be deleted
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :additional_details, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :div
        system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "DangerDialog-additionalDetails"
        )

        system_arguments[:display] ||= :flex
        system_arguments[:align_items] ||= :center
        system_arguments[:justify_content] ||= :center
        system_arguments[:mb] ||= 3

        Primer::BaseComponent.new(**system_arguments)
      }

      # @param form_arguments [Hash] Allows the dialog to submit a form. Pass EITHER the `builder:` option to this hash to reuse an existing Rails form, or `action:` if you prefer the component to render the form tag itself. `builder:` should be an instance of `ActionView::Helpers::FormBuilder`, which is created by the standard Rails `#form_with` and `#form_for` helpers. The `name:` option is the desired name of the field that will be included in the params sent to the server on form submission.
      # @param id [String] The id of the dialog.
      # @param title [String] The title of the dialog. Although visually hidden, a label is rendered for assistive technologies.
      # @param confirm_button_text [String] The text of the confirm button. Will default to `I18n.t("button_delete")`, or `I18n.t("button_delete_permanently")` if `confirmation_check_box` slot has been passed to the component.
      # @param cancel_button_text [String] The text of the cancel button. Will default to `I18n.t("button_cancel")`.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        form_arguments: {},
        id: self.class.generate_id,
        title:,
        confirm_button_text: nil,
        cancel_button_text: nil,
        **system_arguments
      )
        @check_box_name = form_arguments.delete(:name) || "confirm_dangerous_action"
        @form_wrapper = FormWrapper.new(**form_arguments)
        @dialog_id = id.to_s

        @confirm_button_text = confirm_button_text
        @cancel_button_text = cancel_button_text

        deny_single_argument(:role, "`role` will always be set to `alertdialog`.", **system_arguments)

        @system_arguments = system_arguments
        @system_arguments[:id] = @dialog_id
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "DangerDialog"
        )
        @system_arguments[:role] = "alertdialog"

        @dialog = Primer::Alpha::Dialog.new(title: title, subtitle: nil, visually_hide_title: true, **@system_arguments)
      end

      delegate :labelledby, :header?, :header, :with_header, :with_header_content,
               :show_button?, :show_button, :with_show_button, :with_show_button_content,
               to: :@dialog

      def render?
        raise ArgumentError, "DangerDialog requires a confirmation_message" unless confirmation_message?

        confirmation_message?
      end

      private

      def before_render
        @confirm_button_text ||= confirmation_check_box? ? I18n.t("button_delete_permanently") : I18n.t("button_delete")
        @cancel_button_text ||= I18n.t("button_cancel")
      end
    end
  end
end
