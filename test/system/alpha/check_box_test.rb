# frozen_string_literal: true

require "system/test_case"
require "test_helpers/focus_test_helpers"

module Alpha
  class IntegrationCheckBoxTest < System::TestCase
    include Primer::KeyboardTestHelpers
    include Primer::JsTestHelpers
    include Primer::FocusTestHelpers

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

        assert_focus_contrast(focus_styles(".FormControl-checkbox"), theme)

        keyboard.type(:space)
        assert_selector ".FormControl-checkbox:focus-visible:not(:checked)"
      end
    end

    def test_selected_keyboard_focus_has_adjacent_contrast_in_fixed_light_dimmed_mode
      visit_preview(:playground, theme: :dark_dimmed)

      with_dimmed_theme(:light) do
        keyboard.type(:tab)
        keyboard.type(:space)
        assert_selector ".FormControl-checkbox:checked:focus-visible"

        assert_focus_contrast(focus_styles(".FormControl-checkbox"), :fixed_light_dimmed)
      end
    end

    def test_selected_keyboard_focus_honors_a_later_theme_stylesheet_override
      visit_preview(:playground, theme: :dark_dimmed)
      execute_script(<<~JS)
        const style = document.createElement('style')
        style.textContent = "[data-color-mode='dark'][data-dark-theme='dark_dimmed'] { --focus-outlineColor: #ffcc00; }"
        document.head.appendChild(style)
      JS

      keyboard.type(:tab)
      keyboard.type(:space)
      assert_selector ".FormControl-checkbox:checked:focus-visible"

      focus = focus_styles(".FormControl-checkbox")
      assert_equal "rgb(255, 204, 0)", focus["color"], "the later consumer stylesheet must set the outline"
      assert_focus_contrast(focus, :stylesheet)
    end

    {
      checkbox: ".FormControl-checkbox",
      container: ".FormControl-checkbox-wrap",
      root: "html"
    }.each do |scope, selector|
      define_method("test_selected_keyboard_focus_honors_#{scope}_token_override") do
        visit_preview(:playground, theme: :dark_dimmed)

        execute_script("arguments[0].style.setProperty('--focus-outlineColor', '#ffcc00')", find(selector))
        refute find(:checkbox, "Jean-Luc Picard").checked?

        keyboard.type(:tab)
        assert_selector ".FormControl-checkbox:focus-visible"
        keyboard.type(:space)
        assert_selector ".FormControl-checkbox:checked:focus-visible"

        focus = focus_styles(".FormControl-checkbox")
        assert_equal "rgb(255, 204, 0)", focus["color"], "#{scope}: the consumer focus token must set the outline"
        assert_focus_contrast(focus, scope)
      end
    end

    private

    def assert_focus_contrast(focus, scope)
      inner_contrast = contrast_ratio(focus["color"], focus["innerColor"])
      outer_contrast = contrast_ratio(focus["color"], focus["outerColor"])

      assert_equal "solid", focus["style"]
      assert_operator focus["width"], :>=, 2
      assert_equal 2, focus["offset"], "#{scope}: outline offset; inner adjacent contrast #{inner_contrast}:1"
      assert_operator inner_contrast, :>=, 3, "#{scope}: outline against the inner adjacent color"
      assert_operator outer_contrast, :>=, 3, "#{scope}: outline against the outer canvas"
    end
  end
end
