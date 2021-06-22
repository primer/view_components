# frozen_string_literal: true

require "linter_test_case"

class ArgumentMappersSystemArgumentsTest < LinterTestCase
  def test_returns_aria_arguments_as_string_symbols
    @file = '<div aria-label="label" aria-boolean>'

    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["aria-label"]).to_args
    assert_equal({ '"aria-label"' => '"label"' }, args)

    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["aria-boolean"]).to_args
    assert_equal({ '"aria-boolean"' => "" }, args)
  end

  def test_returns_data_arguments_as_string_symbols
    @file = '<div data-action="click" data-pjax>'

    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["data-action"]).to_args
    assert_equal({ '"data-action"' => '"click"' }, args)

    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["data-pjax"]).to_args
    assert_equal({ '"data-pjax"' => "" }, args)
  end

  def test_raises_if_cannot_map_attribute
    @file = '<div some-attribute="some-value">'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["some-attribute"]).to_args
    end

    assert_equal "Cannot convert attribute \"some-attribute\"", err.message
  end

  def test_converts_data_test_selector
    @file = '<div data-test-selector="some-selector">'
    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["data-test-selector"]).to_args

    assert_equal({ test_selector: '"some-selector"' }, args)
  end

  def test_converts_erb_test_selector_call
    @file = '<div <%= test_selector("some-selector") %>>'
    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes.each.first).to_args

    assert_equal({ test_selector: '"some-selector"' }, args)
  end

  def test_raises_if_unsupported_erb_block
    @file = '<div <%= some_method("some-selector") %>>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes.each.first).to_args
    end

    assert_equal "Cannot convert erb block", err.message
  end

  def test_raises_if_attribute_has_erb_value
    @file = '<div aria-label="<%= some_call %>">'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["aria-label"]).to_args
    end

    assert_equal "Cannot convert attribute \"aria-label\" because its value contains an erb block", err.message
  end

  def test_raises_if_attribute_has_erb_interpolation
    @file = '<div aria-label="interpolating <%= some_call %>">'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["aria-label"]).to_args
    end

    assert_equal "Cannot convert attribute \"aria-label\" because its value contains an erb block", err.message
  end
end
