# frozen_string_literal: true

require "lib/test_helper"

class Primer::JoinStyleArgumentsHelperTest < Minitest::Test
  include Primer::JoinStyleArgumentsHelper

  def test_combines_two_inline_styles
    assert_equal(
      "width: 100%;background-color: red",
      join_style_arguments("width: 100%", "background-color: red")
    )
  end

  def test_combines_three_inline_styles
    assert_equal(
      "width: 100%;background-color: red;color: blue",
      join_style_arguments("width: 100%", "background-color: red", "color: blue")
    )
  end

  def test_handles_nil
    assert_equal(
      "width: 100%",
      join_style_arguments("width: 100%", nil)
    )

    assert_equal(
      "width: 100%",
      join_style_arguments(nil, "width: 100%")
    )
  end
end
