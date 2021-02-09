# frozen_string_literal: true

require "test_helper"

class PrimerBorderBoxComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_an_empty_box
    render_inline(Primer::BorderBoxComponent.new)

    refute_selector("div.Box")
    refute_selector(".Box-header")
    refute_selector(".Box-body")
    refute_selector(".Box-row")
    refute_selector(".Box-footer")
  end

  def test_renders_header
    render_inline(Primer::BorderBoxComponent.new) do |component|
      component.slot(:header) { "Header" }
    end

    assert_selector("div.Box-header", text: "Header")
  end

  def test_renders_body
    render_inline(Primer::BorderBoxComponent.new) do |component|
      component.slot(:body) { "Body" }
    end

    assert_selector("div.Box-body", text: "Body")
  end

  def test_renders_footer
    render_inline(Primer::BorderBoxComponent.new) do |component|
      component.slot(:footer) { "Footer" }
    end

    assert_selector("div.Box-footer", text: "Footer")
  end

  def test_renders_multiple_rows
    render_inline(Primer::BorderBoxComponent.new) do |component|
      component.slot(:row) { "First" }
      component.slot(:row) { "Second" }
      component.slot(:row) { "Third" }
    end

    assert_selector("ul", count: 1)
    assert_selector("li.Box-row", count: 3)
  end

  def test_status
    assert_equal Primer::BorderBoxComponent.status, Primer::Component::STATUSES[:beta]
  end
end
