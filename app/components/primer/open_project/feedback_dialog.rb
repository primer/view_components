# frozen_string_literal: true

module Primer
  module OpenProject
    # A pre-configured dialog which includes the FeedbackMessage
    class FeedbackDialog < Primer::Component
      status :open_project

      # A feedback message with some defaults that are necessary for rendering nicely.
      #
      # To render the message heading (required), call the `with_heading` method, which accepts a `:tag` argument, along with the arguments accepted by <%= link_to_component(Primer::Beta::Heading) %>.
      #
      # To render the message description, call the `with_description` method, which accepts <%= link_to_system_arguments_docs %>
      #
      # @param icon_arguments [Hash] the system_arguments for the icon
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :feedback_message, lambda { |icon_arguments: {}, **system_arguments|
        system_arguments[:border] = false
        system_arguments[:id] = "#{@system_arguments[:id]}-description"

        Primer::OpenProject::FeedbackMessage.new(icon_arguments: icon_arguments, **system_arguments)
      }

      # Optional additional details, like a form input or toast.
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

      # @param title [String] The title of the dialog. Although visually hidden, a label is rendered for assistive technologies.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(title:, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "FeedbackDialog"
        )
        @system_arguments[:id] ||= self.class.generate_id

        @dialog = Primer::Alpha::Dialog.new(title: title, subtitle: nil, visually_hide_title: true, **@system_arguments)
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
