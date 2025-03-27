# frozen_string_literal: true

module Primer
  module OpenProject
    class CollapsibleBorderBox < Primer::Component
      status :open_project

      # renders_one :header, lambda { |title:, count: nil, **system_arguments|
      #   Primer::OpenProject::CollapsibleBorderBox::Header.new(title: title, count: count, **system_arguments)
      # }

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(title:, count: nil, **system_arguments)
        @title = title
        @count = count
        @system_arguments = system_arguments

        @border_box = Primer::Beta::BorderBox.new(**@system_arguments)
      end

      delegate :body?, :body, :with_body, :with_body_content,
               :footer?, :footer, :with_footer, :with_footer_content,
               :row?, :row, :with_row, :with_row_content,
               to: :@border_box

      private

      def before_render


        content
      end
    end
  end
end
