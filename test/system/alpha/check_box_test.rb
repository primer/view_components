# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationCheckBoxTest < System::TestCase
    include Primer::KeyboardTestHelpers
    include Primer::JsTestHelpers

    %w[light dark dark_dimmed light_colorblind dark_colorblind light_high_contrast dark_high_contrast].each do |theme|
      define_method("test_selected_keyboard_focus_has_adjacent_contrast_in_#{theme}") do
        visit_preview(:playground, theme: theme)

        theme_attribute = theme.start_with?("dark") ? "data-dark-theme" : "data-light-theme"
        assert_selector "html[#{theme_attribute}='#{theme}']"
        refute find(:checkbox, "Jean-Luc Picard").checked?

        keyboard.type(:tab)
        assert_selector ".FormControl-checkbox:focus-visible"
        keyboard.type(:space)
        assert_selector ".FormControl-checkbox:checked:focus-visible"

        focus = evaluate_multiline_script(<<~JS)
          const checkbox = document.querySelector('input.FormControl-checkbox')
          const style = getComputedStyle(checkbox)
          const offset = Number.parseFloat(style.outlineOffset)
          let ancestor = checkbox.parentElement

          while (ancestor) {
            const background = getComputedStyle(ancestor)
            if (background.backgroundImage !== 'none') {
              throw new Error('Expected the adjacent CheckBox canvas to have no background image')
            }
            if (background.backgroundColor !== 'rgba(0, 0, 0, 0)') {
              return {
                offset,
                width: Number.parseFloat(style.outlineWidth),
                style: style.outlineStyle,
                color: style.outlineColor,
                outerColor: background.backgroundColor,
                // Without the gap, the selected border touches the outline.
                innerColor: offset > 0 ? background.backgroundColor : style.borderTopColor,
              }
            }
            ancestor = ancestor.parentElement
          }
          throw new Error('The CheckBox preview has no opaque adjacent canvas')
        JS

        inner_contrast = contrast_ratio(focus["color"], focus["innerColor"])
        outer_contrast = contrast_ratio(focus["color"], focus["outerColor"])

        assert_equal "solid", focus["style"]
        assert_operator focus["width"], :>=, 2
        assert_equal 2, focus["offset"], "#{theme}: outline offset; inner adjacent contrast #{inner_contrast}:1"
        assert_operator inner_contrast, :>=, 3, "#{theme}: outline against the inner adjacent color"
        assert_operator outer_contrast, :>=, 3, "#{theme}: outline against the outer canvas"

        keyboard.type(:space)
        assert_selector ".FormControl-checkbox:focus-visible:not(:checked)"
      end
    end

    private

    def contrast_ratio(first, second)
      lower, higher = [luminance(first), luminance(second)].minmax
      (higher + 0.05) / (lower + 0.05)
    end

    def luminance(color)
      match = /\Argb\((\d+),\s*(\d+),\s*(\d+)\)\z/.match(color)
      raise ArgumentError, "Expected an opaque RGB color, received #{color}" unless match

      channels = match.captures.map do |channel|
        value = channel.to_f / 255
        value <= 0.04045 ? value / 12.92 : ((value + 0.055) / 1.055)**2.4
      end

      0.2126 * channels[0] + 0.7152 * channels[1] + 0.0722 * channels[2]
    end
  end
end
