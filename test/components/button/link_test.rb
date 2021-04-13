# frozen_string_literal: true

require "test_helper"

class PrimerButtonLinkTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Button::Link.new) { "link" }

    assert_selector("button[type='button'].btn-link", text: "link")
    refute_selector(".btn")
  end

  def test_renders_as_block
    render_inline(Primer::Button::Link.new(block: true)) { "link" }

    assert_selector("button[type='button'].btn-link.btn-block", text: "link")
    refute_selector(".btn")
  end

  def test_does_not_render_as_button_group
    render_inline(Primer::Button::Link.new(group_item: true)) { "link" }

    refute_selector(".BtnGroup-item")
  end

  def test_does_not_render_variants
    render_inline(Primer::Button::Link.new(variant: :large)) { "link" }

    refute_selector(".btn-large")
  end
end
