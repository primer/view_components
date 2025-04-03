# frozen_string_literal: true

module Primer
  module OpenProject
    module BorderBox
      # A component to be used inside Primer::Beta::BorderBox.
      # It will toggle the visibility of the complete Box body
      class CollapsibleHeader < Primer::Component
        status :open_project

        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(title:, count: nil, description: nil, collapsed: false, box:, **system_arguments)
          @title = title
          @count = count
          @description = description
          @collapsed = collapsed
          @box = box
          @system_arguments = system_arguments

          @system_arguments[:tag] = "collapsible-header"
          @system_arguments[:classes] = class_names(
            system_arguments[:classes],
            "CollapsibleHeader",
            "CollapsibleHeader--collapsed" => @collapsed
          )
          @system_arguments[:data] = merge_data(
            @system_arguments, {
            data: {
              action: "click:collapsible-header#toggle",
              collapsed: @collapsed
            } }
          )
        end

        private

        def before_render
          content
        end

        def render?
          raise ArgumentError, "Title must be present" unless @title.present?
          raise ArgumentError, "Description cannot be a blank string" unless @description.present? || @description.nil?
          raise ArgumentError, "Count cannot be a blank string" unless @count.present? || @count.nil?
          raise ArgumentError, "This component must be called inside the header of a `Primer::Beta::BorderBox`" unless @box.present? && @box.is_a?(Primer::Beta::BorderBox)

          true
        end
      end
    end
  end
end
