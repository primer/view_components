# frozen_string_literal: true

require "lib/test_helper"

class Primer::SafeHrefHelperTest < Minitest::Test
  include Primer::SafeHrefHelper

  def test_returns_false_for_nil
    refute Primer::SafeHrefHelper.unsafe_href?(nil)
  end

  def test_returns_false_for_relative_paths
    refute Primer::SafeHrefHelper.unsafe_href?("/foo/bar")
    refute Primer::SafeHrefHelper.unsafe_href?("foo/bar")
    refute Primer::SafeHrefHelper.unsafe_href?("#anchor")
    refute Primer::SafeHrefHelper.unsafe_href?("?query=1")
    refute Primer::SafeHrefHelper.unsafe_href?("")
  end

  def test_returns_false_for_safe_schemes
    refute Primer::SafeHrefHelper.unsafe_href?("https://example.com")
    refute Primer::SafeHrefHelper.unsafe_href?("http://example.com")
    refute Primer::SafeHrefHelper.unsafe_href?("mailto:foo@example.com")
    refute Primer::SafeHrefHelper.unsafe_href?("ftp://example.com")
    refute Primer::SafeHrefHelper.unsafe_href?("tel:+15551234567")
    refute Primer::SafeHrefHelper.unsafe_href?("data:image/png;base64,abc")
  end

  def test_detects_javascript_uri
    assert Primer::SafeHrefHelper.unsafe_href?("javascript:alert(1)")
  end

  def test_detects_vbscript_uri
    assert Primer::SafeHrefHelper.unsafe_href?("vbscript:msgbox(1)")
  end

  def test_detects_mixed_case_schemes
    assert Primer::SafeHrefHelper.unsafe_href?("JaVaScRiPt:alert(1)")
    assert Primer::SafeHrefHelper.unsafe_href?("JAVASCRIPT:alert(1)")
    assert Primer::SafeHrefHelper.unsafe_href?("VbScript:alert(1)")
  end

  def test_detects_leading_whitespace_bypasses
    assert Primer::SafeHrefHelper.unsafe_href?(" javascript:alert(1)")
    assert Primer::SafeHrefHelper.unsafe_href?("\tjavascript:alert(1)")
    assert Primer::SafeHrefHelper.unsafe_href?("\njavascript:alert(1)")
    assert Primer::SafeHrefHelper.unsafe_href?("\rjavascript:alert(1)")
  end

  def test_detects_embedded_whitespace_and_control_chars_in_scheme
    # Browsers strip tab/CR/LF inside URLs per the WHATWG URL spec, so these execute.
    assert Primer::SafeHrefHelper.unsafe_href?("java\tscript:alert(1)")
    assert Primer::SafeHrefHelper.unsafe_href?("java\nscript:alert(1)")
    assert Primer::SafeHrefHelper.unsafe_href?("java\rscript:alert(1)")
    assert Primer::SafeHrefHelper.unsafe_href?("j\u0000avascript:alert(1)")
  end

  def test_does_not_misclassify_schemes_that_merely_contain_javascript
    refute Primer::SafeHrefHelper.unsafe_href?("https://example.com/javascript:foo")
    refute Primer::SafeHrefHelper.unsafe_href?("/javascript:foo")
  end

  def test_handles_non_string_values
    refute Primer::SafeHrefHelper.unsafe_href?(123)
    refute Primer::SafeHrefHelper.unsafe_href?(:foo)
  end

  def test_instance_method_delegates_to_module_method
    assert unsafe_href?("javascript:alert(1)")
    refute unsafe_href?("https://example.com")
  end
end
