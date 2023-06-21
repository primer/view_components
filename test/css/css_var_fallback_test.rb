# frozen_string_literal: true

require "components/test_helper"

class Primer::CssVariableTest < Minitest::Test
  def test_css_rules_all_contain_fallbacks
    # 1. Find compiled CSS file
    css_file = Rails.root.join(*%w[.. app assets styles primer_view_components.css]).read

    # 2. Load file and run regex on it which checks for any CSS var containing new color terms
    regex = /var\(--(shadow|borderColor|bgColor|fgColor|iconColor)[^),]*\)\s*(,|;|\s)/
    matches = css_file.scan(regex)

    # 3. Use assert method (and friends) to verify it works
    missing_vars = matches.map { |match| match[0] }
    assert_equal 0, matches.length, "CSS variables are missing fallbacks: #{missing_vars.join(', ')}"
  end
end
