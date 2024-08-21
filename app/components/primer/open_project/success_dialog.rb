# frozen_string_literal: true

module Primer
  module OpenProject
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class SuccessDialog < Primer::Alpha::Dialog
      status :open_project

      attr_accessor :message_icon

      # A success message with some defaults that are necessary for rendering nicely
      # together with an optional additional content.
      #
      # @param heading [String] the heading for the success message
      # @param description [String] the description for the success message
      # @param icon [Symbol] Octicon icon to use at top of the success message.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :confirmation_message, lambda { |**system_arguments|
        arguments = {}
        arguments[:heading] = system_arguments.delete(:heading)
        arguments[:description] = system_arguments.delete(:description)
        arguments[:icon] = message_icon
        arguments[:border] = false
        arguments[:p] = 0

        Primer::OpenProject::ConfirmationMessage.new(**arguments)
      }

      # Optional additional_content like a form input or toast.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :additional_content, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :div

        Primer::BaseComponent.new(**system_arguments)
      }

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = "div"
        # no title or subtitle for the dialog - use the heading of the success message instead
        @system_arguments[:title] = ""
        @system_arguments[:subtitle] = ""
        # calling super will swallow the message icon, it needs to be remembered separately
        self.message_icon = @system_arguments[:message_icon]

        super(**system_arguments)
      end
    end
  end
end
