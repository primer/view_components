# frozen_string_literal: true

module Primer
  module OpenProject
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class ZenModeButton < Primer::Component
      status :open_project

      ZEN_MODE_BUTTON_LABEL = I18n.t("label_zen_mode")
      ZEN_MODE_BUTTON_ICON = "screen-full"

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = "zen-mode-button"
        @system_arguments[:classes] =
        class_names(
          @system_arguments[:classes],
          "ZenModeButton"
        )

        @button_size = @system_arguments[:size] || Primer::Beta::Button::DEFAULT_SIZE
      end
    end
  end
end
