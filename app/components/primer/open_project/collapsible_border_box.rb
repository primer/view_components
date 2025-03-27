# frozen_string_literal: true

module Primer
  module OpenProject
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class CollapsibleBorderBox < Primer::Component
      status :open_project

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments

        @border_box = Primer::Beta::BorderBox.new(**@system_arguments)
      end

      delegate :body?, :body, :with_body, :with_body_content,
               :footer?, :footer, :with_footer, :with_footer_content,
               :rows?, :rows, :with_row, :with_row_content,
               to: :@border_box
    end

    private

    def before_render
      content
    end

    def render?
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts body.present?
      true
    end
  end
end
