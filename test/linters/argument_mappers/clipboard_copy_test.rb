# frozen_string_literal: true

require "linter_test_case"

class ArgumentMappersClipboardCopyTest < LinterTestCase
  def test_returns_value_argument
    @file = "<clipboard-copy value=\"some value\"></clipboard-copy>"
    args = ERBLint::Linters::ArgumentMappers::ClipboardCopy.new(tags.first).to_args

    assert_equal({ value: '"some value"' }, args)
  end

  def test_returns_arguments_as_string
    @file = "<clipboard-copy value=\"some value\"></clipboard-copy>"
    args = ERBLint::Linters::ArgumentMappers::ClipboardCopy.new(tags.first).to_s

    assert_equal 'value: "some value"', args
  end

  def test_raises_if_value_has_erb_value
    @file = '<clipboard-copy value="<%= some_call %>">'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::ClipboardCopy.new(tags.first).to_args
    end

    assert_equal "Cannot convert attribute \"value\" because its value contains an erb block", err.message
  end
end
