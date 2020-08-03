# frozen_string_literal: true

require "test_helper"
require "primer/fetch_or_fallback_helper"

class Primer::FetchOrFallbackHelperTest < Minitest::Test
  include Primer::FetchOrFallbackHelper

  def test_one_of
    assert_equal(fetch_or_fallback([1, 2, 3], 3, 2), 3)
    assert_equal(fetch_or_fallback([1, 2, 3], 0, 2), 2)
    assert_equal(fetch_or_fallback([1, 2, 3], nil, 2), 2)
    assert_equal(fetch_or_fallback([1, 2, 3], "1", 2), 2)
    assert_equal(fetch_or_fallback([1, 2, 3], "one", 2), 2)
    assert_equal(fetch_or_fallback([1, 2, 3], false, 2), 2)
    assert_equal(fetch_or_fallback([1, 2, 3], true, 2), 2)
    assert_nil(fetch_or_fallback([1, 2, 3], true))
  end

  def test_raises_on_fallback_in_development
    ::Rails.stubs(:development?).returns(true)
    error = assert_raises Primer::FetchOrFallbackHelper::InvalidValueError do
      fetch_or_fallback([1, 2, 3], 0, 1)
    end

    assert_match /Expected one of: \[1, 2, 3\]/, error.message
    assert_match /Got: 0/, error.message
    assert_match /This will not raise in production, but will instead fallback to: 1/, error.message
  end
end
