# frozen_string_literal: true

require "system/test_case"

module Beta
  class IntegrationBlankslateTest < System::TestCase
    include Primer::JsTestHelpers

    def test_has_a_width_when_inside_a_flex_container
      visit_preview(:inside_flex_container)

      info = evaluate_multiline_script(<<~JS)
        const style = window.getComputedStyle(document.querySelector('.blankslate'));
        return {
          width: style.getPropertyValue('width'),
          padding: style.getPropertyValue('padding')
        }
      JS

      width = info["width"].to_i
      padding = info["padding"].to_i
      calc_width = width - (padding * 2)

      assert calc_width > 0, "Blankslate appears to have zero width"
    end
  end
end
