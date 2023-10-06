# frozen_string_literal: true

module Primer
  module OpenProject
    class GridLayout
      # GridLayout::Area is an internal component that wraps the items in a div with the given new class and responding "grid-area"
      class Area < Primer::Component
        status :open_project

        DEFAULT_TAG = :div
        TAG_OPTIONS = [DEFAULT_TAG, :span].freeze

        # @param css_class [String] The basic css class applied on the grid-container
        # @param area_name [Symbol] The specific area name, used for creating the element class and the "grid-area" style
        # @param component [ViewComponent::Base] The instance of the component to be rendered.
        # @param tag [Symbol] <%= one_of(Primer::OpenProject::GridLayout::Area::TAG_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(css_class, area_name, component = ::Primer::BaseComponent, tag: DEFAULT_TAG, **system_arguments)
          @component = component
          @system_arguments = system_arguments
          @styles = [
            "grid-area: #{area_name}"
          ]
          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
          @system_arguments[:style] = join_style_arguments(@system_arguments[:style], *@styles)
          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            "#{css_class}--#{area_name}"
          )
        end

        def call
          render(@component.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
