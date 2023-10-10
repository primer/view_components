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
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", full_width: full_width, hide_labels: hide_labels, size: size)) do |component|
          component.with_item(label: "Preview", icon: icon, selected: true)
          component.with_item(label: "Raw", icon: icon)
          component.with_item(label: "Blame", icon: icon)
        end
      end

      # @label Default
      # @snapshot
      def default
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view")) do |component|
          component.with_item(label: "Preview", selected: true)
          component.with_item(label: "Raw")
          component.with_item(label: "Blame")
        end
      end

      # @!group Full width
      # @label Size small
      # @param hide_labels [Boolean] toggle
      # @snapshot
      def full_width_small(hide_labels: false)
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: hide_labels, full_width: true, size: :small)) do |component|
          component.with_item(label: "Preview", selected: true)
          component.with_item(label: "Raw")
          component.with_item(label: "Blame")
        end
      end

      # @label Size medium
      # @param hide_labels [Boolean] toggle
      # @snapshot
      def full_width_medium(hide_labels: false)
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: hide_labels, full_width: true, size: :medium)) do |component|
          component.with_item(label: "Preview", selected: true)
          component.with_item(label: "Raw")
          component.with_item(label: "Blame")
        end
      end

      # @label Size large
      # @param hide_labels [Boolean] toggle
      # @snapshot
      def full_width_large(hide_labels: false)
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: hide_labels, full_width: true, size: :large)) do |component|
          component.with_item(label: "Preview", selected: true)
          component.with_item(label: "Raw")
          component.with_item(label: "Blame")
        end
      end
      # @!endgroup

      # @!group Icons and text
      # @label Size small
      # @snapshot
      def icons_and_text_small
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", size: :small)) do |component|
          component.with_item(label: "Preview", icon: :eye, selected: true)
          component.with_item(label: "Raw", icon: :"file-code")
          component.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Size medium
      # @snapshot
      def icons_and_text_medium
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", size: :medium)) do |component|
          component.with_item(label: "Preview", icon: :eye, selected: true)
          component.with_item(label: "Raw", icon: :"file-code")
          component.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Size large
      # @snapshot
      def icons_and_text_large
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", size: :large)) do |component|
          component.with_item(label: "Preview", icon: :eye, selected: true)
          component.with_item(label: "Raw", icon: :"file-code")
          component.with_item(label: "Blame", icon: :people)
        end
      end
      # @!endgroup

      # @!group Trailing Label
      # @label Size small
      # @snapshot
      def trailing_label_width_small
        render(Primer::Alpha::SegmentedControl.new("aria-label": "Billing duration", size: :small)) do |component|
          component.with_item(label: "Monthly")
          component.with_item(label: "Yearly", selected: true, trailing_visual_label: "-8%", trailing_visual_label_options: { scheme: :accent })
        end
      end

      # @label Size medium
      # @snapshot
      def trailing_label_width_medium
        render(Primer::Alpha::SegmentedControl.new("aria-label": "Billing duration", size: :medium)) do |component|
          component.with_item(label: "Monthly")
          component.with_item(label: "Yearly", selected: true, trailing_visual_label: "-8%", trailing_visual_label_options: { scheme: :accent })
        end
      end

      # @label Size large
      # @snapshot
      def trailing_label_width_large
        render(Primer::Alpha::SegmentedControl.new("aria-label": "Billing duration", size: :large)) do |component|
          component.with_item(label: "Monthly")
          component.with_item(label: "Yearly", selected: true, trailing_visual_label: "-8%", trailing_visual_label_options: { scheme: :accent })
        end
      end
      # @!endgroup

      # @!group Icons only
      # @label Size small
      # @snapshot
      def icon_only_small
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, size: :small)) do |component|
          component.with_item(label: "Preview", icon: :eye, selected: true)
          component.with_item(label: "Raw", icon: :"file-code")
          component.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Size medium
      # @snapshot
      def icon_only_medium
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, size: :medium)) do |component|
          component.with_item(label: "Preview", icon: :eye, selected: true)
          component.with_item(label: "Raw", icon: :"file-code")
          component.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Size large
      # @snapshot
      def icon_only_large
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, size: :large)) do |component|
          component.with_item(label: "Preview", icon: :eye, selected: true)
          component.with_item(label: "Raw", icon: :"file-code")
          component.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Full width, size small
      def icon_only_full_width_small
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, full_width: true, size: :small)) do |component|
          component.with_item(label: "Preview", icon: :eye, selected: true)
          component.with_item(label: "Raw", icon: :"file-code")
          component.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Full width, size medium
      def icon_only_full_width_medium
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, full_width: true, size: :medium)) do |component|
          component.with_item(label: "Preview", icon: :eye, selected: true)
          component.with_item(label: "Raw", icon: :"file-code")
          component.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Full width, size large
      def icon_only_full_width_large
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, full_width: true, size: :large)) do |component|
          component.with_item(label: "Preview", icon: :eye, selected: true)
          component.with_item(label: "Raw", icon: :"file-code")
          component.with_item(label: "Blame", icon: :people)
        end
      end
      # @!endgroup

      # NOTE: this preview uses a group to force it's display below the other groups
      # @!group With link as tag
      # @snapshot
      def with_link_as_tag
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view")) do |component|
          component.with_item(tag: :a, href: "#", label: "Preview", icon: :eye, selected: true)
          component.with_item(tag: :a, href: "#", label: "Raw", icon: :"file-code")
          component.with_item(tag: :a, href: "#", label: "Blame", icon: :people)
        end
      end
      # @!endgroup

      # @!group With aria labeled headings
      # @snapshot
      def with_subhead_actions; end

      # @snapshot
      def with_label_and_caption; end
      # @!endgroup
    end
  end
end
