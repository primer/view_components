# frozen_string_literal: true

require "lib/test_helper"

class Primer::FetchOrFallbackHelperTest < Minitest::Test
  include Primer::FetchOrFallbackHelper
  include Primer::ComponentTestHelpers

  def test_one_of
    Primer::FetchOrFallbackHelper.fallback_raises = false

    assert_equal(fetch_or_fallback([1, 2, 3], 3, 2), 3)
    assert_equal(fetch_or_fallback([1, 2, 3], 0, 2), 2)
    assert_equal(fetch_or_fallback([1, 2, 3], nil, 2), 2)
    assert_equal(fetch_or_fallback([1, 2, 3], "1", 2), 2)
    assert_equal(fetch_or_fallback([1, 2, 3], "one", 2), 2)
    assert_equal(fetch_or_fallback([1, 2, 3], false, 2), 2)
    assert_equal(fetch_or_fallback([1, 2, 3], true, 2), 2)
    assert_nil(fetch_or_fallback([1, 2, 3], true))
  ensure
    Primer::FetchOrFallbackHelper.fallback_raises = true
  end

  def test_accepts_deprecated_values
    assert_equal(fetch_or_fallback([1, 2], 3, deprecated_values: [3]), 3)
  end

  def test_warns_of_deprecation_if_not_silenced
    with_silence_deprecations(false) do
      ::Primer::ViewComponents.deprecation.expects(:warn).with("3 is deprecated and will be removed in a future version.").once
      assert_equal(fetch_or_fallback([1, 2], 3, deprecated_values: [3]), 3)
    end
  end

  def test_does_not_raise_in_production
    ENV["RAILS_ENV"] = "production"
    assert_equal(fetch_or_fallback([1, 2, 3], nil, 2), 2)
  ensure
    ENV["RAILS_ENV"] = "test"
  end

  def test_raises_on_fallback_in_non_production
    error = assert_raises Primer::FetchOrFallbackHelper::InvalidValueError do
      fetch_or_fallback([1, 2, 3], 0, 1)
    end

    assert_match(/Expected one of: \[1, 2, 3\]/, error.message)
    assert_match(/Got: 0/, error.message)
    assert_match(/This will not raise in production, but will instead fallback to: 1/, error.message)
  end

  def test_fetch_boolean
    assert_equal true, fetch_or_fallback_boolean(true, :fallback_value)
    assert_equal false, fetch_or_fallback_boolean(false, :fallback_value)
  end

  def test_fetch_boolean_fallback
    assert_equal :fallback_value, fetch_or_fallback_boolean("foo", :fallback_value)
  end
end
