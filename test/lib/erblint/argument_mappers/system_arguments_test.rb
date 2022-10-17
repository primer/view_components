# frozen_string_literal: true

require "lib/erblint_test_case"

class ArgumentMappersSystemArgumentsTest < ErblintTestCase
  def test_returns_aria_arguments_as_string_symbols
    @file = '<div aria-label="label" aria-boolean>'

    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["aria-label"]).to_args
    assert_equal({ '"aria-label"' => '"label"' }, args)

    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["aria-boolean"]).to_args
    assert_equal({ '"aria-boolean"' => '""' }, args)
  end

  def test_returns_data_arguments_as_string_symbols
    @file = '<div data-action="click" data-pjax>'

    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["data-action"]).to_args
    assert_equal({ '"data-action"' => '"click"' }, args)

    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["data-pjax"]).to_args
    assert_equal({ '"data-pjax"' => '""' }, args)
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

  def test_converts_erb_test_selector_call_with_interpolation
    @file = "<div <%= test_selector(\"some-selector-\#{some_call}\") %>>"
    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes.each.first).to_args

    assert_equal({ test_selector: "\"some-selector-\#{some_call}\"" }, args)
  end

  def test_converts_data_test_selector_with_basic_interpolation
    @file = '<div data-test-selector="<%= some_call %>">'
    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes.each.first).to_args

    assert_equal({ test_selector: "some_call" }, args)
  end

  def test_converts_data_test_selector_with_interpolation_with_string
    @file = '<div data-test-selector="string-<%= some_call %>">'
    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes.each.first).to_args

    assert_equal({ test_selector: "\"string-\#{ some_call }\"" }, args)
  end

  def test_converts_data_test_selector_with_multiple_interpolations
    @file = '<div data-test-selector="string-<%= some_call %><%= other_call %>-more-<%= another_call %>">'
    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes.each.first).to_args

    assert_equal({ test_selector: "\"string-\#{ some_call }\#{ other_call }-more-\#{ another_call }\"" }, args)
  end

  def test_raises_if_unsupported_erb_block
    @file = '<div <%= some_method("some-selector") %>>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes.each.first).to_args
    end

    assert_equal "Cannot convert erb block", err.message
  end

  def test_converts_aria_label_with_basic_interpolation
    @file = '<div aria-label="<%= some_call %>">'
    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["aria-label"]).to_args

    assert_equal({ '"aria-label"' => "some_call" }, args)
  end

  def test_converts_aria_label_with_interpolation_with_string
    @file = '<div aria-label="string-<%= some_call %>">'
    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["aria-label"]).to_args

    assert_equal({ '"aria-label"' => "\"string-\#{ some_call }\"" }, args)
  end

  def test_converts_aria_label_with_multiple_interpolations
    @file = '<div aria-label="string-<%= some_call %><%= other_call %>-more-<%= another_call %>">'
    args = ERBLint::Linters::ArgumentMappers::SystemArguments.new(tags.first.attributes["aria-label"]).to_args

    assert_equal({ '"aria-label"' => "\"string-\#{ some_call }\#{ other_call }-more-\#{ another_call }\"" }, args)
  end
end
