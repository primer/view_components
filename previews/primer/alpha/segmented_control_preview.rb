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

      # @label Default
      def default
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view")) do |c|
          c.with_item(label: "Preview", selected: true)
          c.with_item(label: "Raw")
          c.with_item(label: "Blame")
        end
      end

      # @!group Full width
      # @label Size small
      # @param hide_labels [Boolean] toggle
      def full_width_small(hide_labels: false)
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: hide_labels, full_width: true, size: :small)) do |c|
          c.with_item(label: "Preview", selected: true)
          c.with_item(label: "Raw")
          c.with_item(label: "Blame")
        end
      end

      # @label Size medium
      # @param hide_labels [Boolean] toggle
      def full_width_medium(hide_labels: false)
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: hide_labels, full_width: true, size: :medium)) do |c|
          c.with_item(label: "Preview", selected: true)
          c.with_item(label: "Raw")
          c.with_item(label: "Blame")
        end
      end

      # @label Size large
      # @param hide_labels [Boolean] toggle
      def full_width_large(hide_labels: false)
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: hide_labels, full_width: true, size: :large)) do |c|
          c.with_item(label: "Preview", selected: true)
          c.with_item(label: "Raw")
          c.with_item(label: "Blame")
        end
      end
      # @!endgroup

      # @!group Icons and text
      # @label Size small
      def icons_and_text_small
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", size: :small)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Size medium
      def icons_and_text_medium
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", size: :medium)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Size large
      def icons_and_text_large
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", size: :large)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end
      # @!endgroup

      # @!group Icons only
      # @label Size small
      def icon_only_small
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, size: :small)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Size medium
      def icon_only_medium
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, size: :medium)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Size large
      def icon_only_large
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, size: :large)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Full width, size small
      def icon_only_full_width_small
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, full_width: true, size: :small)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Full width, size medium
      def icon_only_full_width_medium
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, full_width: true, size: :medium)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end

      # @label Full width, size large
      def icon_only_full_width_large
        render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true, full_width: true, size: :large)) do |c|
          c.with_item(label: "Preview", icon: :eye, selected: true)
          c.with_item(label: "Raw", icon: :"file-code")
          c.with_item(label: "Blame", icon: :people)
        end
      end
      # @!endgroup

      # NOTE: this preview uses a group to force it's display below the other groups
      # @!group With link as tag
      def with_link_as_tag
        render(Primer::Alpha::SegmentedControl.new) do |c|
          c.with_item(tag: :a, href: "#", label: "Preview", icon: :eye, selected: true)
          c.with_item(tag: :a, href: "#", label: "Raw", icon: :"file-code")
          c.with_item(tag: :a, href: "#", label: "Blame", icon: :people)
        end
      end
      # @!endgroup
    end
  end
end
