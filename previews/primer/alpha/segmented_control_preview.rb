# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module Alpha
    # @label SegmentedControl
    class SegmentedControlPreview < ViewComponent::Preview
      # @param full_width [Boolean] toggle
      # @param icon_only [Symbol] select [always, never, when_narrow]
      # @param number_of_buttons [Integer] number
      def default(full_width: false, number_of_buttons: 3, icon_only: :never)
        render(Primer::Alpha::SegmentedControl.new(full_width: full_width, icon_only: icon_only)) do |c|
          Array.new(number_of_buttons || 3) do |i|
            c.with_item(label: "Button #{i + 1}", icon: (icon_only == :never ? nil : :zap), selected: i.zero?)
          end
        end
      end

      # @param icon_only [Symbol] select [always, never, when_narrow]
      # @param number_of_buttons [Integer] number
      def full_width(number_of_buttons: 3, icon_only: :never)
        render(Primer::Alpha::SegmentedControl.new(full_width: true, icon_only: icon_only)) do |c|
          Array.new(number_of_buttons || 3) do |i|
            c.with_item(label: "Button #{i + 1}", icon: (icon_only == :never ? nil : :zap), selected: i.zero?)
          end
        end
      end

      # @param full_width [Boolean] toggle
      # @param number_of_buttons [Integer] number
      def icons_and_text(full_width: false, number_of_buttons: 3)
        render(Primer::Alpha::SegmentedControl.new(full_width: full_width)) do |c|
          Array.new(number_of_buttons || 3) do |i|
            c.with_item(label: "Button #{i + 1}", icon: :zap, selected: i.zero?)
          end
        end
      end

      # @param full_width [Boolean] toggle
      # @param number_of_buttons [Integer] number
      def icons_only(full_width: false, number_of_buttons: 3)
        render(Primer::Alpha::SegmentedControl.new(full_width: full_width, icon_only: :always)) do |c|
          Array.new(number_of_buttons || 3) do |i|
            c.with_item(label: "Button #{i + 1}", icon: :zap, selected: i.zero?)
          end
        end
      end

      # @param full_width [Boolean] toggle
      # @param number_of_buttons [Integer] number
      def icons_only_when_narrow(full_width: false, number_of_buttons: 3)
        render(Primer::Alpha::SegmentedControl.new(full_width: full_width, icon_only: :when_narrow)) do |c|
          Array.new(number_of_buttons || 3) do |i|
            c.with_item(label: "Button #{i + 1}", icon: :zap, selected: i.zero?)
          end
        end
      end

      def with_links_as_tags
        render(Primer::Alpha::SegmentedControl.new) do |c|
          c.with_item(label: "Button 1", icon: :zap, tag: :a, href: "#", selected: true)
          c.with_item(label: "Button 2", icon: :zap, tag: :a, href: "#")
          c.with_item(label: "Button 3", icon: :zap, tag: :a, href: "#")
        end
      end
    end
  end
end
