# frozen_string_literal: true

require "lib/erblint_test_case"

class ArgumentMappersBaseTest < ErblintTestCase
  def test_returns_no_arguments_no_attributes
    @file = "<div></div>"
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_empty args
  end

  def test_returns_known_system_arguments
    @file = '<div class="mr-1 p-3 d-none d-md-block anim-fade-in"></div>'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_equal({
                   mr: 1,
                   p: 3,
                   display: [:none, nil, :block],
                   animation: ":fade_in"
                 }, args)
  end

  def test_returns_known_system_arguments_as_string
    @file = '<div class="mr-1 p-3 d-none d-md-block anim-fade-in"></div>'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_s

    assert_equal("mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in", args)
  end

  def test_raises_if_a_class_cannot_be_converted
    @file = '<div class="mr-1 p-3 d-none d-md-block anim-fade-in text-fuzzy-waffle"></div>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_s
    end

    assert_equal("Cannot convert class text-fuzzy-waffle", err.message)
  end

  def test_returns_aria_arguments_as_string_symbols
    @file = '<div aria-label="label" aria-boolean>'

    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args
    assert_equal({ '"aria-label"' => '"label"', '"aria-boolean"' => '""' }, args)
  end

  def test_returns_data_arguments_as_string_symbols
    @file = '<div data-action="click" data-pjax>'

    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args
    assert_equal({ '"data-action"' => '"click"', '"data-pjax"' => '""' }, args)
  end

  def test_converts_data_test_selector
    @file = '<div data-test-selector="some-selector">'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_equal({ test_selector: '"some-selector"' }, args)
  end

  def test_converts_erb_test_selector_call
    @file = '<div <%= test_selector("some-selector") %>>'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_equal({ test_selector: '"some-selector"' }, args)
  end

  def test_raises_if_unsupported_erb_block
    @file = '<div <%= some_method("some-selector") %>>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args
    end

    assert_equal "Cannot convert erb block", err.message
  end

  def test_converts_aria_label_with_basic_interpolation
    @file = '<div aria-label="<%= some_call %>">'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_equal({ '"aria-label"' => "some_call" }, args)
  end

  def test_converts_aria_label_with_interpolation_with_string
    @file = '<div aria-label="string-<%= some_call %>">'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_equal({ '"aria-label"' => "\"string-\#{ some_call }\"" }, args)
  end

  def test_converts_aria_label_with_multiple_interpolations
    @file = '<div aria-label="string-<%= some_call %><%= other_call %>-more-<%= another_call %>">'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_equal({ '"aria-label"' => "\"string-\#{ some_call }\#{ other_call }-more-\#{ another_call }\"" }, args)
  end

  def test_returns_arguments_as_string
    @file = '<div aria-label="some label" aria-boolean data-pjax data-action="click">'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_s

    assert_equal '"aria-label": "some label", "aria-boolean": "", "data-pjax": "", "data-action": "click"', args
  end

  def test_raises_if_cannot_map_attribute
    @file = '<div some-attribute="some-value">'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args
    end

    assert_equal "Cannot convert attribute \"some-attribute\"", err.message
  end

  def test_returns_custom_classes_as_string
    @file = '<div class="custom-1 custom-2">'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_equal({ classes: "\"custom-1 custom-2\"" }, args)
  end

  def test_raises_if_class_contains_an_erb_block
    @file = '<div class="string-<%= some_call %>">'

    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args
    end

    assert_equal("Cannot convert attribute \"class\" because its value contains an erb block", err.message)
  end

  def test_does_not_convert_special_elements
    @file = '<div aria-label="&quot;<%= some_call %>&quot;">'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_equal({ '"aria-label"' => "\"&quot;\#{ some_call }&quot;\"" }, args)
  end
end
