# frozen_string_literal: true

module Primer
  module OpenProject
    module BorderBox
      # A component to be used inside Primer::Beta::BorderBox.
      # It will toggle the visibility of the complete Box body
      class CollapsibleHeader < Primer::Component
        status :open_project

        # Required title
        #
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_one :title, lambda { |**system_arguments, &block|
          system_arguments[:mr] ||= 2

          Primer::Beta::Text.new(**system_arguments, &block)
        }

        # Optional count
        #
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_one :count, lambda { |**system_arguments|
          system_arguments[:mr] ||= 2
          system_arguments[:scheme] ||= :primary

          Primer::Beta::Counter.new(**system_arguments)
        }

        # Optional description
        #
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_one :description, lambda { |**system_arguments, &block|
          system_arguments[:color] ||= :subtle
          system_arguments[:data] = merge_data(
            system_arguments, {
            data: {
                target: "collapsible-header.collapsibleElements"
              }
            }
          )

          Primer::Beta::Text.new(**system_arguments, &block)
        }


        # @param collapsed [Boolean] Whether the header is collapsed on initial render.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(collapsed: false, box:, **system_arguments)
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
          raise ArgumentError, "Title must be present" unless title?
          raise ArgumentError, "This component must be called inside the header of a `Primer::Beta::BorderBox`" unless @box.present? && @box.is_a?(Primer::Beta::BorderBox)

          true
        end
      end
    end
  end
end
