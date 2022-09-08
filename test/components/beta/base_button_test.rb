# frozen_string_literal: true

require "test_helper"

class PrimerBetaBaseButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Beta::BaseButton.new) { "content" }

    assert_text("content")
  end

  def test_renders_a_without_button_role
    render_inline(Primer::Beta::BaseButton.new(tag: :a)) { "content" }

    assert_selector("a")
    refute_selector("a[role='button']")
    refute_selector("a[type]")
  end

  def test_renders_summary_without_button_role
    render_inline(Primer::Beta::BaseButton.new(tag: :summary)) { "content" }

    assert_selector("summary")
    refute_selector("summary[role='button']")
    refute_selector("summary[type]")
  end

  def test_renders_href
    render_inline(Primer::Beta::BaseButton.new(href: "www.example.com")) { "content" }

    assert_selector("button[href='www.example.com']")
  end

  def test_renders_button_block
    render_inline(Primer::Beta::BaseButton.new(block: true)) { "content" }

    assert_selector(".btn-block")
  end

  def test_primer_base_button_references_beta_base_button
    assert_equal(Primer::BaseButton.superclass, Primer::Beta::BaseButton)

    render_inline(Primer::BaseButton.new) { "Primer::BaseButton content" }

    assert_text("Primer::BaseButton content")
  end
end
