# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module Alpha
    # @label SegmentedControl
    class SegmentedControlPreview < ViewComponent::Preview
      NUMBER_OF_BUTTONS_DEFAULT = 3

      # @param full_width [Boolean] toggle
      # @param icon_only [Boolean] toggle
      # @param icon_only_when_narrow [Boolean] toggle
      # @param number_of_buttons [Integer] number
      def default(full_width: false, number_of_buttons: NUMBER_OF_BUTTONS_DEFAULT, icon_only: false, icon_only_when_narrow: false)
        render(Primer::Alpha::SegmentedControl.new(full_width: full_width, icon_only: icon_only, icon_only_when_narrow: icon_only_when_narrow)) do |c|
          Array.new(number_of_buttons || NUMBER_OF_BUTTONS_DEFAULT) do |i|
            c.button(text: "Button #{i + 1}", selected: i.zero?) do |b|
              b.leading_visual_icon(icon: :zap) if icon_only || icon_only_when_narrow
            end
          end
        end
      end

      # @param full_width [Boolean] toggle
      # @param number_of_buttons [Integer] number
      def full_width(full_width: true, number_of_buttons: NUMBER_OF_BUTTONS_DEFAULT)
        render(Primer::Alpha::SegmentedControl.new(full_width: full_width)) do |c|
          Array.new(number_of_buttons || NUMBER_OF_BUTTONS_DEFAULT) do |i|
            c.button(text: "Button #{i + 1}", selected: i.zero?)
          end
        end
      end

      # @param full_width [Boolean] toggle
      # @param number_of_buttons [Integer] number
      def icons_and_text(full_width: false, number_of_buttons: NUMBER_OF_BUTTONS_DEFAULT)
        render(Primer::Alpha::SegmentedControl.new(full_width: full_width)) do |c|
          Array.new(number_of_buttons || NUMBER_OF_BUTTONS_DEFAULT) do |i|
            c.button(text: "Button #{i + 1}", selected: i.zero?) do |b|
              b.leading_visual_icon(icon: :zap)
            end
          end
        end
      end

      # @param full_width [Boolean] toggle
      # @param icon_only [Boolean] toggle
      # @param number_of_buttons [Integer] number
      def icons_only(full_width: false, number_of_buttons: NUMBER_OF_BUTTONS_DEFAULT, icon_only: true)
        render(Primer::Alpha::SegmentedControl.new(full_width: full_width, icon_only: icon_only)) do |c|
          Array.new(number_of_buttons || NUMBER_OF_BUTTONS_DEFAULT) do |i|
            c.button(text: "Button #{i + 1}", selected: i.zero?) do |b|
              b.leading_visual_icon(icon: :zap)
            end
          end
        end
      end

      # @param icon_only_when_narrow [Boolean] toggle
      # @param full_width [Boolean] toggle
      # @param number_of_buttons [Integer] number
      def icons_only_when_narrow(full_width: false, number_of_buttons: NUMBER_OF_BUTTONS_DEFAULT, icon_only_when_narrow: true)
        render(Primer::Alpha::SegmentedControl.new(full_width: full_width, icon_only_when_narrow: icon_only_when_narrow)) do |c|
          Array.new(number_of_buttons || NUMBER_OF_BUTTONS_DEFAULT) do |i|
            c.button(text: "Button #{i + 1}", selected: i.zero?) do |b|
              b.leading_visual_icon(icon: :zap)
            end
          end
        end
      end
    end
  end
end
