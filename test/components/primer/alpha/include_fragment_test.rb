# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaIncludeFragmentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Alpha::IncludeFragment.new)

    assert_selector("include-fragment[loading='eager']")
  end

  def test_renders_lazy
    render_inline(Primer::Alpha::IncludeFragment.new(loading: :lazy))

    assert_selector("include-fragment[loading='lazy']")
  end

  def test_renders_with_src
    render_inline(Primer::Alpha::IncludeFragment.new(src: "/some/path"))

    assert_selector("include-fragment[src='/some/path']")
  end
end
