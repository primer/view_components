# frozen_string_literal: true

module Primer
  module Beta
    # @label Subhead
    class SubheadPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param spacious [Boolean]
      # @param hide_border [Boolean]
      # @param heading_danger [Boolean]
      # @param heading_tag [Symbol] select [div, h1, h2, h3, h4, h5, h6]
      def playground(spacious: false, hide_border: false, heading_tag: :div, heading_danger: false)
        render(Primer::Beta::Subhead.new(spacious: spacious, hide_border: hide_border)) do |component|
          component.with_heading(tag: heading_tag, danger: heading_danger) do
            "My Heading"
          end
          component.with_description do
            "My Description"
          end
        end
      end

      # @label Default Options
      #
      # @param spacious [Boolean]
      # @param hide_border [Boolean]
      # @param heading_danger [Boolean]
      # @param heading_tag [Symbol] select [div, h1, h2, h3, h4, h5, h6]
      def default(spacious: false, hide_border: false, heading_tag: :div, heading_danger: false)
        render(Primer::Beta::Subhead.new(spacious: spacious, hide_border: hide_border)) do |component|
          component.with_heading(tag: heading_tag, danger: heading_danger) do
            "My Heading"
          end
          component.with_description do
            "My Description"
          end
        end
      end
    end
  end
end
