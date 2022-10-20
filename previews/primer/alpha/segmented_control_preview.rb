# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module Alpha
    # @label SegmentedControl
    class SegmentedControlPreview < ViewComponent::Preview
      # @label Playground
      # @param full_width [Boolean] toggle
      # @param hide_labels [Boolean] toggle
      # @param icon [Symbol] octicon
      # @param size select [small, medium, large]
      def playground(full_width: false, hide_labels: false, size: :medium, icon: :none)
        if icon == :none
          icon = hide_labels ? :zap : nil
        end
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", full_width: full_width, hide_labels: hide_labels, size: size)) do |c|
          c.with_item(label: "Preview", icon: icon, selected: true)
          c.with_item(label: "Raw", icon: icon)
          c.with_item(label: "Blame", icon: icon)
        end
      end

      # @param full_width [Boolean] toggle
      # @param size select [small, medium, large]
      def default(full_width: false, size: :medium)
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", full_width: full_width, size: size)) do |c|
          c.with_item(label: "Preview", selected: true)
          c.with_item(label: "Raw")
          c.with_item(label: "Blame")
        end
      end

      # @param hide_labels [Boolean] toggle
      # @param size select [small, medium, large]
      def full_width(hide_labels: false, size: :medium)
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", full_width: true, hide_labels: hide_labels, size: size)) do |c|
          c.with_item(label: "Preview", icon: (hide_labels ? :zap : nil), selected: true)
          c.with_item(label: "Raw", icon: (hide_labels ? :zap : nil))
          c.with_item(label: "Blame", icon: (hide_labels ? :zap : nil))
        end
      end

      # @param full_width [Boolean] toggle
      # @param size select [small, medium, large]
      def icons_and_text(full_width: false, size: :medium)
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", full_width: full_width, size: size)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end

      # @param full_width [Boolean] toggle
      # @param size select [small, medium, large]
      def icons_only(full_width: false, size: :medium)
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", full_width: full_width, hide_labels: true, size: size)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end

      def with_links_as_tags
        render(Primer::Alpha::SegmentedControl.new) do |c|
          c.with_item(tag: :a, href: "#", label: "Preview", icon: :eye, selected: true)
          c.with_item(tag: :a, href: "#", label: "Raw", icon: :"file-code")
          c.with_item(tag: :a, href: "#", label: "Blame", icon: :people)
        end
      end
    end
  end
end
