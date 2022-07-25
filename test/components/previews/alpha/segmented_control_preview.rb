# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Alpha
  # @label SegmentedControl
  class SegmentedControlPreview < ViewComponent::Preview
    # @param full_width [Boolean] toggle
    # @param number_of_buttons [Integer] number
    def default(full_width: false, number_of_buttons: 4)
      render(Primer::Alpha::SegmentedControl.new(full_width: full_width)) do |c|
        Array.new(number_of_buttons || 4) do |i|
          c.button(text: "Button #{i + 1}", selected: i.zero?)
        end
      end
    end

    # @param full_width [Boolean] toggle
    # @param number_of_buttons [Integer] number
    def icons_and_text(full_width: false, number_of_buttons: 4)
      render(Primer::Alpha::SegmentedControl.new(full_width: full_width)) do |c|
        Array.new(number_of_buttons || 4) do |i|
          c.button(text: "Button #{i + 1}", selected: i.zero?) do |b|
            b.leading_visual_icon(icon: :zap)
          end
        end
      end
    end

    # @param full_width [Boolean] toggle
    # @param number_of_buttons [Integer] number
    def icons_only(full_width: false, number_of_buttons: 4)
      render(Primer::Alpha::SegmentedControl.new(full_width: full_width, icon_only: true)) do |c|
        Array.new(number_of_buttons || 4) do |i|
          c.button(text: "Button #{i + 1}", selected: i.zero?) do |b|
            b.leading_visual_icon(icon: :zap)
          end
        end
      end
    end

    # @param full_width [Boolean] toggle
    # @param number_of_buttons [Integer] number
    def icons_only_when_narrow(full_width: false, number_of_buttons: 4)
      render(Primer::Alpha::SegmentedControl.new(full_width: full_width, icon_only: :when_narrow)) do |c|
        Array.new(number_of_buttons || 4) do |i|
          c.button(text: "Button #{i + 1}", selected: i.zero?) do |b|
            b.leading_visual_icon(icon: :zap)
          end
        end
      end
    end
  end
end
