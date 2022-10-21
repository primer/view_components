# frozen_string_literal: true

require "lib/test_helper"

class Primer::ClassNameHelperTest < Minitest::Test
  include Primer::ClassNameHelper

  def test_includes_class_names_passed_as_strings
    assert_equal "foo bar", class_names("foo", "bar")
  end

  def test_allows_hashes_with_symbols
    assert_equal "foo", class_names({ foo: true, bar: false })
  end

  def test_allows_multiple_hashes
    assert_equal "foo", class_names({ foo: true }, { bar: false })
  end

  def test_ignores_invalid_values
    assert_equal "foo bar", class_names(nil, false, 123, "", "foo", { bar: true })
  end

  def test_handles_arrays
    assert_equal "foo", class_names([{ foo: true }], [{ bar: false }])
  end
end
