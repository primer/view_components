# frozen_string_literal: true

require "system/test_case"
require "test_helpers/focus_test_helpers"

module Alpha
  class IntegrationCheckBoxTest < System::TestCase
    include Primer::KeyboardTestHelpers
    include Primer::JsTestHelpers
    include Primer::FocusTestHelpers

    %w[light dark dark_dimmed light_colorblind dark_colorblind light_high_contrast dark_high_contrast].each do |theme|
      define_method("test_selected_keyboard_focus_keeps_its_gap_in_#{theme}") do
        visit_preview(:playground, theme: theme)

        theme_attribute = theme.start_with?("dark") ? "data-dark-theme" : "data-light-theme"
        assert_selector "html[#{theme_attribute}='#{theme}']"
        refute find(:checkbox, "Jean-Luc Picard").checked?

        keyboard.type(:tab)
        assert_selector ".FormControl-checkbox:focus-visible"
        keyboard.type(:space)
        assert_selector ".FormControl-checkbox:checked:focus-visible"

        assert_focus_gap(focus_styles(".FormControl-checkbox"), theme)

        keyboard.type(:space)
        assert_selector ".FormControl-checkbox:focus-visible:not(:checked)"
      end
    end

    {
      fixed_dark: [:dark, nil, "[data-color-mode='dark'][data-dark-theme='dark_dimmed']"],
      fixed_light: [:light, nil, "[data-color-mode='light'][data-light-theme='dark_dimmed']"],
      automatic_light: [:auto, "light", "[data-color-mode='auto'][data-light-theme='dark_dimmed']"],
      automatic_dark: [:auto, "dark", "[data-color-mode][data-color-mode='auto'][data-dark-theme='dark_dimmed']"]
    }.each do |mode_name, (mode, preference, theme_selector)|
      { legacy: "--focus-outlineColor", modern: "--focus-outline-color" }.each do |token_name, token|
        define_method("test_selected_keyboard_focus_honors_#{token_name}_theme_token_override_in_#{mode_name}") do
          visit_preview(:playground, theme: :dark_dimmed)

          with_dimmed_theme(mode, preference: preference) do
            execute_script(<<~JS, theme_selector, token)
              const style = document.createElement('style')
              style.textContent = `${arguments[0]} { ${arguments[1]}: #ffcc00; }`
              document.head.appendChild(style)
            JS

            keyboard.type(:tab)
            keyboard.type(:space)
            assert_selector ".FormControl-checkbox:checked:focus-visible"

            assert_consumer_focus_color(focus_styles(".FormControl-checkbox"), "#{mode_name}: #{token_name}")
          end
        end
      end
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
        assert_consumer_focus_color(focus, scope)
      end
    end

    def test_options_have_individual_accessible_names_in_the_full_page
      visit "/lookbook/preview/primer/alpha/check_box/options"

      assert_selector ".FormControl-checkbox", count: 4
      assert_selector :checkbox, "Jean-Luc Picard", count: 4, disabled: :all
      labels = evaluate_multiline_script(<<~JS)
        return Array.from(document.querySelectorAll('.FormControl-checkbox'), checkbox =>
          Array.from(checkbox.labels, label => label.textContent.trim()))
      JS
      assert_equal [["Jean-Luc Picard"]] * 4, labels

      if Primer::DriverTestHelpers.chrome?
        tree = page.driver.browser.page.command("Accessibility.getFullAXTree")
        names = tree["nodes"].select { |node| node.dig("role", "value") == "checkbox" }.map { |node| node.dig("name", "value") }
        assert_equal ["Jean-Luc Picard"] * 4, names
      end
    end

    private

    def assert_focus_gap(focus, scope)
      assert_equal "solid", focus["style"]
      assert_operator focus["width"], :>=, 2
      assert_equal 2, focus["offset"], "#{scope}: the selected checkbox must retain its focus gap"
    end

    def assert_consumer_focus_color(focus, scope)
      assert_equal "rgb(255, 204, 0)", focus["color"], "#{scope}: the consumer focus token must set the outline"
      assert_focus_gap(focus, scope)
      assert_operator contrast_ratio(focus["color"], focus["innerColor"]), :>=, 3, "#{scope}: outline against the inner adjacent color"
      assert_operator contrast_ratio(focus["color"], focus["outerColor"]), :>=, 3, "#{scope}: outline against the outer canvas"
    end
  end
end
