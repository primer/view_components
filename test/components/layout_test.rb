# frozen_string_literal: true

require "test_helper"

class PrimerLayoutTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_container
    render_inline(Primer::Layout.new(container: :xl))

    assert_selector(".container-xl") do
      assert_selector(".Layout")
    end
  end

  def test_renders_without_container
    render_inline(Primer::Layout.new(container: :full))

    Primer::Layout::CONTAINER_OPTIONS.each do |c|
      refute_selector(".container-#{c}")
    end
    assert_selector(".Layout")
  end

  def test_sidebar_width
    render_inline(Primer::Layout.new(sidebar_width: :narrow))

    assert_selector(".Layout.Layout--sidebar-narrow")
  end

  def test_gutter
    render_inline(Primer::Layout.new(gutter: :condensed))

    assert_selector(".Layout.Layout--gutter-condensed")
  end
end
