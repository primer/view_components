# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaBorderBoxTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_an_empty_box
    render_inline(Primer::Beta::BorderBox.new)

    refute_selector("div.Box")
    refute_selector(".Box-header")
    refute_selector(".Box-body")
    refute_selector(".Box-row")
    refute_selector(".Box-footer")
  end

  def test_renders_header
    render_inline(Primer::Beta::BorderBox.new) do |component|
      component.with_header { "Header" }
    end

    assert_selector("div.Box-header", text: "Header")
  end

  def test_renders_body
    render_inline(Primer::Beta::BorderBox.new) do |component|
      component.with_body { "Body" }
    end

    assert_selector("div.Box-body", text: "Body")
  end

  def test_renders_footer
    render_inline(Primer::Beta::BorderBox.new) do |component|
      component.with_footer { "Footer" }
    end

    assert_selector("div.Box-footer", text: "Footer")
  end

  def test_renders_multiple_rows
    render_inline(Primer::Beta::BorderBox.new) do |component|
      component.with_row { "First" }
      component.with_row { "Second" }
      component.with_row { "Third" }
    end

    assert_selector("ul", count: 1)
    assert_selector("li.Box-row", count: 3)
  end

  def test_renders_condensed
    render_inline(Primer::Beta::BorderBox.new(padding: :condensed)) do |component|
      component.with_body { "Body" }
    end

    assert_selector("div.Box.Box--condensed")
  end

  def test_renders_spacious
    render_inline(Primer::Beta::BorderBox.new(padding: :spacious)) do |component|
      component.with_body { "Body" }
    end

    assert_selector("div.Box.Box--spacious")
  end

  def test_status
    assert_component_state(Primer::Beta::BorderBox, :beta)
  end

  def test_restricts_allowed_system_arguments
    with_raise_on_invalid_options(true) do
      error = assert_raises(ArgumentError) do
        render_inline(Primer::Beta::BorderBox.new(p: 4)) do |component|
          component.with_body { "Body" }
        end
      end

      assert_includes(error.message, "Perhaps you could consider using")
    end
  end

  def test_strips_denied_system_arguments
    with_raise_on_invalid_options(false) do
      render_inline(Primer::Beta::BorderBox.new(p: 4)) do |component|
        component.with_body { "Body" }
      end
    end

    refute_selector(".p-4")
  end

  def test_renders_row_with_schemes
    { neutral: "gray", info: "blue", warning: "yellow" }.each_pair do |scheme, color|
      render_inline(Primer::Beta::BorderBox.new) do |component|
        component.with_row(scheme: scheme) { "Row, row, row your boat" }
      end

      assert_selector(".Box .Box-row--#{color}")
    end
  end

  def test_renders_row_with_default_scheme
    render_inline(Primer::Beta::BorderBox.new) do |component|
      component.with_row { "Row, row, row your boat" }
    end

    assert_selector(".Box .Box-row")
  end
end
