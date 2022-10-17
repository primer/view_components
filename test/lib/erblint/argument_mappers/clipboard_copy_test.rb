# frozen_string_literal: true

require "lib/erblint_test_case"

class ArgumentMappersClipboardCopyTest < ErblintTestCase
  def test_returns_value_argument
    @file = "<clipboard-copy value=\"some value\"></clipboard-copy>"
    args = ERBLint::Linters::ArgumentMappers::ClipboardCopy.new(tags.first).to_args

    assert_equal({ value: '"some value"' }, args)
  end

  def test_returns_for_argument
    @file = "<clipboard-copy for=\"some value\"></clipboard-copy>"
    args = ERBLint::Linters::ArgumentMappers::ClipboardCopy.new(tags.first).to_args

    assert_equal({ for: '"some value"' }, args)
  end

  def test_returns_arguments_as_string
    @file = "<clipboard-copy value=\"some value\"></clipboard-copy>"
    args = ERBLint::Linters::ArgumentMappers::ClipboardCopy.new(tags.first).to_s

    assert_equal 'value: "some value"', args
  end

  def test_with_system_arguments
    @file = '
      <clipboard-copy
        class="mr-1 p-3 d-md-block d-none anim-fade-in"
        value="some value"
      ></clipboard-copy>'

    args = ERBLint::Linters::ArgumentMappers::ClipboardCopy.new(tags.first).to_args

    assert_equal({
                   value: '"some value"',
                   mr: 1,
                   p: 3,
                   display: [:none, nil, :block],
                   animation: ":fade_in"
                 }, args)
  end

  def test_converts_basic_interpolation
    @file = '<clipboard-copy value="<%= some_call %>">'
    args = ERBLint::Linters::ArgumentMappers::ClipboardCopy.new(tags.first).to_args

    assert_equal({ value: "some_call" }, args)
  end

  def test_converts_interpolation_with_string
    @file = '<clipboard-copy value="string-<%= some_call %>">'
    args = ERBLint::Linters::ArgumentMappers::ClipboardCopy.new(tags.first).to_args

    assert_equal({ value: "\"string-\#{ some_call }\"" }, args)
  end

  def test_converts_multiple_interpolations
    @file = '<clipboard-copy value="string-<%= some_call %><%= other_call %>-more-<%= another_call %>">'
    args = ERBLint::Linters::ArgumentMappers::ClipboardCopy.new(tags.first).to_args

    assert_equal({ value: "\"string-\#{ some_call }\#{ other_call }-more-\#{ another_call }\"" }, args)
  end
end
