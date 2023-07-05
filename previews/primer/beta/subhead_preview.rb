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
      # @snapshot
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

      # @label Danger
      # @snapshot
      def danger
        render(Primer::Beta::Subhead.new) do |component|
          component.with_heading(danger: true) do
            "Danger Heading"
          end
          component.with_description do
            "A description of the 'danger'"
          end
        end
      end

      # @label Actions
      # @snapshot
      def actions
        render_with_template(locals: {})
      end

      # @!group Spacing
      #
      # @label Default
      def spacing_default
        render(Primer::Beta::Subhead.new(spacious: false)) do |component|
          component.with_heading do
            "Default Spacing"
          end
          component.with_description do
            "Default spacing above the component"
          end
        end
      end

      # @label Spacious
      # @snapshot
      def spacing_spacious
        render(Primer::Beta::Subhead.new(spacious: true)) do |component|
          component.with_heading do
            "Spacious"
          end
          component.with_description do
            "With extra space above the component"
          end
        end
      end

      # @label Spacious w/ Danger Heading
      def spacing_dangerous
        render(Primer::Beta::Subhead.new(spacious: true)) do |component|
          component.with_heading(danger: true) do
            "Danger Heading"
          end
          component.with_description do
            "With extra space above the component, and a 'danger' heading"
          end
        end
      end
      #
      # @!endgroup
    end
  end
end
