# frozen_string_literal: true

require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "color_themes returns expected themes" do
    expected_themes = %w[
      light
      light_colorblind
      light_high_contrast
      dark
      dark_dimmed
      dark_high_contrast
      dark_colorblind
    ]
    
    assert_equal expected_themes, color_themes
  end

  test "color_theme_attributes with valid theme" do
    result = color_theme_attributes("dark")
    assert_includes result, "data-color-mode:dark"
    assert_includes result, "data-dark-theme:dark"
  end

  test "color_theme_attributes with invalid theme defaults to light" do
    result = color_theme_attributes("invalid")
    assert_includes result, "data-color-mode:light"
    assert_includes result, "data-light-theme:light"
  end

  test "color_theme_attributes with no theme defaults to light" do
    result = color_theme_attributes
    assert_includes result, "data-color-mode:light"
    assert_includes result, "data-light-theme:light"
  end

  test "tag_attributes formats key-value pairs" do
    attributes = { "data-test": "value", "class": "example" }
    result = tag_attributes(attributes)
    assert_includes result, "data-test=value"
    assert_includes result, "class=example"
  end
end