# frozen_string_literal: true

require "test_helper"

class PrimerLayoutTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_doesnt_render_without_both_slots
    render_inline(Primer::Layout.new)
    refute_component_rendered

    render_inline(Primer::Layout.new) { |c| c.main { "Main" } }
    refute_component_rendered

    render_inline(Primer::Layout.new) { |c| c.sidebar { "Sidebar" } }
    refute_component_rendered
  end

  def test_renders_layout
    render_inline(Primer::Layout.new) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".Layout.Layout--sidebarPosition-start") do
      assert_selector(".Layout-main", text: "Main")
      assert_selector(".Layout-sidebar", text: "Sidebar")
    end
  end

  def test_renders_container
    render_inline(Primer::Layout.new(container: :xl)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".container-xl") do
      assert_selector(".Layout")
    end
  end

  def test_renders_without_container
    render_inline(Primer::Layout.new(container: :full)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    Primer::Layout::CONTAINER_OPTIONS.each do |c|
      refute_selector(".container-#{c}")
    end
    assert_selector(".Layout")
  end

  def test_sidebar_width
    render_inline(Primer::Layout.new(sidebar_width: :narrow)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".Layout.Layout--sidebar-narrow")
  end

  def test_gutter
    render_inline(Primer::Layout.new(gutter: :condensed)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".Layout.Layout--gutter-condensed")
  end

  def test_divider
    render_inline(Primer::Layout.new(divider: true)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".Layout") do
      assert_selector(".Layout-main", text: "Main")
      assert_selector(".Layout-divider")
      assert_selector(".Layout-sidebar", text: "Sidebar")
    end
  end

  def test_sidebar_placement
    render_inline(Primer::Layout.new(sidebar_placement: :end)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".Layout.Layout--sidebarPosition-end")
  end

  def test_flow_row_until
    render_inline(Primer::Layout.new(flow_row_until: :md)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".Layout.Layout--flowRow-until-md")
  end

  def test_main_width
    render_inline(Primer::Layout.new(main_width: :lg)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".Layout.Layout--sidebarPosition-start") do
      assert_selector(".Layout-main") do
        assert_selector(".Layout-main-centered-lg") do
          assert_selector(".container-lg", text: "Main")
        end
      end
      assert_selector(".Layout-sidebar", text: "Sidebar")
    end
  end

  def test_density_compact
    render_inline(Primer::Layout.new(density: :compact)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".Layout.m-3")
  end

  def test_density_normal
    render_inline(Primer::Layout.new(density: :normal)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".Layout.m-sm-3.m-lg-4")
  end

  def test_density_relaxed
    render_inline(Primer::Layout.new(density: :relaxed)) do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end

    assert_selector(".Layout.m-sm-3.m-lg-4.m-xl-5")
  end
end
