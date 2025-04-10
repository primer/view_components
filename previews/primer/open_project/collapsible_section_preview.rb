# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label CollapsibleSection
    class CollapsibleSectionPreview < ViewComponent::Preview
      # @label Playground
      # @param caption [String] text
      # @param show_additional_information [Boolean] toggle
      def playground(caption: "(optional)", show_additional_information: false)
        render_with_template(
          template: "primer/open_project/collapsible_section_preview/playground",
          locals: { caption: caption, show_additional_information: show_additional_information}
        )
      end

      # @label Default
      # @snapshot
      def default
        render_with_template(
          template: "primer/open_project/collapsible_section_preview/default",
          locals: { }
        )
      end

      # @label With additional information
      # @snapshot
      def with_additional_information
        render_with_template(
          template: "primer/open_project/collapsible_section_preview/with_additional_information",
          locals: { }
        )
      end

      # @label With caption
      # @snapshot
      def with_caption
        render_with_template(
          template: "primer/open_project/collapsible_section_preview/with_caption",
          locals: { }
        )
      end

      # @label Collapsed
      # @snapshot
      def collapsed
        render_with_template(
          template: "primer/open_project/collapsible_section_preview/collapsed",
          locals: { }
        )
      end
    end
  end
end
