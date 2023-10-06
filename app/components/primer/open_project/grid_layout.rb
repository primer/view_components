# frozen_string_literal: true

module Primer
  module OpenProject
    # A layouting component used to arrange multiple components in a CSS Grid
    # Note that this component only provides helpers (as the class names and grid-area styles).
    # However, it does not define the actual Grid which should be done in a separate CSS-file.
    class GridLayout < Primer::Component
      status :open_project
      attr_reader :css_class

      renders_many :areas, lambda { |area_name, component = ::Primer::BaseComponent, **system_arguments, &block|
        render(Primer::OpenProject::GridLayout::Area.new(@css_class, area_name, component, **system_arguments), &block)
      }

      # @param css_class [String] The basic css class applied on the grid-container
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(css_class:, **system_arguments)
        super

        @system_arguments = system_arguments
        @css_class = css_class
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          css_class
        )
      end

      def render?
        areas.any?
      end
    end
  end
end
