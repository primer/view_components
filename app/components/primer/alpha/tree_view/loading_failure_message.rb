# frozen_string_literal: true

module Primer
  module Alpha
    class TreeView
      # A `TreeView` loading failure message.
      #
      # This component is part of the <%= link_to_component(Primer::Alpha::TreeView) %> component and should
      # not be used directly.
      class LoadingFailureMessage < Primer::Component
        DEFAULT_TEXT = "Something went wrong"
        DEFAULT_RETRY_BUTTON_LABEL = "Retry"

        # @param text [String] The failure message to display.
        # @param retry_button_label [String] The text shown on the retry button.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(text: DEFAULT_TEXT, retry_button_label: DEFAULT_RETRY_BUTTON_LABEL, **system_arguments)
          @text = text
          @retry_button_label = retry_button_label
          @retry_button_arguments = system_arguments.delete(:retry_button_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div
          @system_arguments[:classes] = class_names(
            @system_arguments.delete(:classes),
            "TreeViewFailureMessage"
          )
        end
      end
    end
  end
end
