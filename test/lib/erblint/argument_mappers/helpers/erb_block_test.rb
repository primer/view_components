# frozen_string_literal: true

require "lib/erblint_test_case"

class ArgumentMappersButtonTest < ErblintTestCase
  def test_does_not_convert_interpolation_with_if
    @file = '<div attribute="<% if condition %>Yes<% else %>No<% end %>">'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Helpers::ErbBlock.new.convert(tags.first.attributes["attribute"])
    end

    assert_equal("Cannot convert attribute \"attribute\" because its value contains an erb block", err.message)
  end

  def test_converts_basic_interpolation
    @file = '<div attribute="<%= some_call %>">'
    args = ERBLint::Linters::ArgumentMappers::Helpers::ErbBlock.new.convert(tags.first.attributes["attribute"])

    assert_equal("some_call", args)
  end

  def test_converts_interpolation_with_string
    @file = '<div attribute="string-<%= some_call %>">'
    args = ERBLint::Linters::ArgumentMappers::Helpers::ErbBlock.new.convert(tags.first.attributes["attribute"])

    assert_equal("\"string-\#{ some_call }\"", args)
  end

  def test_converts_multiple_interpolations
    @file = '<div attribute="string-<%= some_call %><%= other_call %>-more-<%= another_call %>">'
    args = ERBLint::Linters::ArgumentMappers::Helpers::ErbBlock.new.convert(tags.first.attributes["attribute"])

    assert_equal("\"string-\#{ some_call }\#{ other_call }-more-\#{ another_call }\"", args)
  end

  def test_converts_ternary_interpolations
    @file = '<div attribute="string-<%= condition ? "Yes" : "No" %>">'
    args = ERBLint::Linters::ArgumentMappers::Helpers::ErbBlock.new.convert(tags.first.attributes["attribute"])

    assert_equal("\"string-\#{ condition ? \"Yes\" : \"No\" }\"", args)
  end

  def test_converts_to_json_if_no_interpolation
    @file = '<div attribute="some_value">'
    args = ERBLint::Linters::ArgumentMappers::Helpers::ErbBlock.new.convert(tags.first.attributes["attribute"])

    assert_equal('"some_value"', args)
  end

  def test_raises_if_erb_block
    @file = '<div attribute="<%= some_call %>">'

    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Helpers::ErbBlock.new.raise_if_erb_block(tags.first.attributes["attribute"])
    end

    assert_equal("Cannot convert attribute \"attribute\" because its value contains an erb block", err.message)
  end

  def test_does_not_raise_if_no_erb_block
    @file = '<div attribute="some_value">'

    ERBLint::Linters::ArgumentMappers::Helpers::ErbBlock.new.raise_if_erb_block(tags.first.attributes["attribute"])
  end
end
