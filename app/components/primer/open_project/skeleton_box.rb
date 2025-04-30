# frozen_string_literal: true

module Primer
  module OpenProject
    # A SkeletonBox provides a placeholder for non-text, non-Avatar elements (e.g., hero images)
    # that are still loading. You can adjust width and height to match the content's dimensions.
    class SkeletonBox < Primer::Component
      # @param height [String] Any valid CSS height.
      # @param width [String] Any valid CSS width.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(height: nil, width: nil, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)

        styles = []
        styles << "width: #{width}" if width
        styles << "height: #{height}" if height

        @system_arguments[:tag] = :div
        @system_arguments[:style] = styles.join("; ") if styles.present?
        @system_arguments[:classes] = class_names(
          @system_arguments.delete(:classes),
          "SkeletonBox"
        )
      end
    end
  end
end
