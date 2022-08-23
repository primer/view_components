# frozen_string_literal: true

module Primer
  module Beta
    # @label Truncate
    class TruncatePreview < ViewComponent::Preview
      # @label Default options
      #
      # @param text [String] text
      def default(text: "branch-name-that-is-really-long")
        render(Primer::Beta::Truncate.new) { text }
      end

      # @label Multiple items
      def multiple_items
        render(Primer::Beta::Truncate.new) do |component|
          component.with_item do
            "really-long-repository-owner-name"
          end
          component.with_item(font_weight: :bold) do
            "really-long-repository-name"
          end
        end
      end

      # @label Advanced multiple items
      def advanced_multiple_items
        render(Primer::Beta::Truncate.new(tag: :ol)) do |component|
          component.with_item(tag: :li) { "primer" }
          component.with_item(tag: :li, priority: true) { "/ css" }
          component.with_item(tag: :li) { "/ Issues" }
          component.with_item(tag: :li) { "/ #123" }
          component.with_item(tag: :li, priority: true) { "Visual bug on primer.style found in lists" }
        end
      end

      # @label Max widths
      def max_widths
        render(Primer::Beta::Truncate.new) do |component|
          component.with_item(max_width: 300) { "branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long" }
          component.with_item(max_width: 200) { "branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long" }
          component.with_item(max_width: 100) { "branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long" }
        end
      end
    end
  end
end
