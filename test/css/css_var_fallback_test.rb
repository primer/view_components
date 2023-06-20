# frozen_string_literal: true

require "components/test_helper"

class Primer::CssVariableTest < Minitest::Test
  def test_css_rules_all_contain_fallbacks
    # 1. Find compiled CSS file
    css_file = Rails.root.join(*%w[.. app assets styles primer_view_components.css]).read

    # 2. Load file and run regex on it
    regex = /var\(--(shadow|borderColor)[^),]*\)\s*(,|;|\s)/
    matches = css_file.scan(regex)

    # 3. Use assert method (and friends) to verify it works
    assert_equal 0, matches.length, "Some CSS rules do not contain fallbacks"
  end
end
