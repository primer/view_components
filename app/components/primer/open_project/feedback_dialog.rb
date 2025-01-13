# frozen_string_literal: true

module Primer
  module OpenProject
    # A pre-configured dialog which includes the FeedbackMessage
    class FeedbackDialog < Primer::Component
      status :open_project

      # A feedback message with some defaults that are necessary for rendering nicely
      #
      # @param heading [String] the heading for the success message
      # @param description [String] the description for the success message
      # @param icon_arguments [Hash] the system_arguments for the icon
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :feedback_message, lambda { |icon_arguments: {}, **system_arguments|
        system_arguments[:border] = false
        Primer::OpenProject::FeedbackMessage.new(icon_arguments: icon_arguments, **system_arguments)
      }

      # Optional additional_details like a form input or toast.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :additional_details, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :div
        system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "FeedbackDialog-additionalDetails"
        )

        system_arguments[:display] ||= :flex
        system_arguments[:align_items] ||= :center
        system_arguments[:justify_content] ||= :center
        system_arguments[:mb] ||= 3

        Primer::BaseComponent.new(**system_arguments)
      }

      renders_one :footer

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "FeedbackDialog"
        )
        @system_arguments[:id] ||= self.class.generate_id

        @dialog = Primer::Alpha::Dialog.new(title: @system_arguments[:title], subtitle: nil, visually_hide_title: true, **@system_arguments)
      end

      delegate :header?, :header, :with_header, :with_header_content,
               :show_button?, :show_button, :with_show_button, :with_show_button_content,
               to: :@dialog

      private

      def before_render
        content
      end
    end
  end
end
