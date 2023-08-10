# frozen_string_literal: true

module Primer
  module Alpha
    # Use `TabContainer` to create tabbed content with keyboard support. This component does not add any styles.
    # It only provides the tab functionality. If you want styled Tabs you can look at <%= link_to_component(Primer::Alpha::TabNav) %>.
    #
    # This component requires javascript.
    class TabContainer < Primer::Component
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = "tab-container"
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end

      def render?
        content.present?
      end
    end
  end
end
