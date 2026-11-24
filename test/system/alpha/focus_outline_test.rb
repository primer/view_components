# frozen_string_literal: true

require "system/test_case"
require "test_helpers/focus_test_helpers"

module Alpha
  module DimmedFocusCoverage
    include Primer::KeyboardTestHelpers
    include Primer::JsTestHelpers
    include Primer::FocusTestHelpers

    {
      fixed_dark: [:dark, nil],
      fixed_light: [:light, nil],
      automatic_light: [:auto, "light"],
      automatic_dark: [:auto, "dark"]
    }.each do |name, (mode, preference)|
      define_method("test_dimmed_focus_color_in_#{name}_mode") do
        visit_preview(:playground, theme: :dark_dimmed)

        with_dimmed_theme(mode, preference: preference) do
          focus_with_keyboard
          assert_focus_color("rgb(71, 139, 230)")
        end
      end
    end

    def test_dimmed_focus_honors_stylesheet_and_inherited_token_overrides
      visit_preview(:playground, theme: :dark_dimmed)
      focus_with_keyboard

      execute_script(<<~JS)
        const style = document.createElement('style')
        style.id = 'consumer-focus-override'
        style.textContent = "[data-color-mode='dark'][data-dark-theme='dark_dimmed'] { --focus-outlineColor: #ffcc00; }"
        document.head.appendChild(style)
      JS
      assert_focus_color("rgb(255, 204, 0)")
      execute_script("document.getElementById('consumer-focus-override').remove()")
      assert_focus_color("rgb(71, 139, 230)")

      control = find(control_selector)
      [find("html"), control.find(:xpath, ".."), control].each do |scope|
        execute_script("arguments[0].style.setProperty('--focus-outlineColor', '#ffcc00')", scope)
        assert_focus_color("rgb(255, 204, 0)")
        execute_script("arguments[0].style.removeProperty('--focus-outlineColor')", scope)
        assert_focus_color("rgb(71, 139, 230)")
      end
    end

    private

    def focus_with_keyboard
      keyboard.type(:tab)
      assert_selector "#{control_selector}:focus-visible"
      keyboard.type(:space)
      assert_selector "#{control_selector}:checked:focus-visible" if control_selector == ".FormControl-radio"
    end

    def assert_focus_color(color)
      find(control_selector).assert_matches_style("outline-color" => color, "outline-width" => "2px", "outline-style" => "solid")
      focus = focus_styles(control_selector)
      assert_operator contrast_ratio(focus["color"], focus["outerColor"]), :>=, 3

      # RadioButton keeps its existing zero-offset outline; this checks the shared color change.
      return if control_selector == ".FormControl-radio"

      assert_equal 2, focus["offset"]
      assert_operator contrast_ratio(focus["color"], focus["innerColor"]), :>=, 3
    end
  end

  class IntegrationRadioButtonTest < System::TestCase
    include DimmedFocusCoverage

    private

    def control_selector
      ".FormControl-radio"
    end
  end

  class IntegrationButtonMarketingTest < System::TestCase
    include DimmedFocusCoverage

    def test_dimmed_focus_color_for_each_marketing_scheme
      %i[default primary outline transparent].each do |scheme|
        visit_preview(:"scheme_#{scheme}", theme: :dark_dimmed)
        focus_with_keyboard
        assert_focus_color("rgb(71, 139, 230)")
      end
    end

    private

    def control_selector
      ".btn-mktg"
    end
  end
end
