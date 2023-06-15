# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaCloseButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Beta::CloseButton.new)

    assert_selector("button[type='button'][aria-label='Close'].close-button") do
      assert_selector(".octicon.octicon-x")
    end
  end

  def test_renders_as_submit
    render_inline(Primer::Beta::CloseButton.new(type: :submit))

    assert_selector("button[type='submit'].close-button") do
      assert_selector(".octicon.octicon-x")
    end
  end

  def test_renders_defaults_type_to_button
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::CloseButton.new(type: :invalid))

      assert_selector("button[type='button'].close-button") do
        assert_selector(".octicon.octicon-x")
      end
    end
  end

  def test_does_not_render_content
    render_inline(Primer::Beta::CloseButton.new) { "content" }

    refute_text("content")
  end

  def test_does_not_render_as_block
    render_inline(Primer::Beta::CloseButton.new(block: true))

    refute_selector(".btn-block")
  end

  def test_can_override_aria_label
    # Test with nested hash style `aria-label`
    render_inline(Primer::Beta::CloseButton.new(aria: { label: "Label" }))
    assert_selector("button[type='button'][aria-label='Label'].close-button")

    # Ensure the default `aria-label` is not in the generated HTML
    #
    # Note: Must use `refute_includes` instead of `refute_selector`. If there
    # are duplicate attributes on a given element, Capybara will ignore the second one.
    # So if we use `refute_selector` the test will pass even if there is a duplicate
    # `aria-label` in the generated HTML.
    refute_includes rendered_content, 'aria-label="Close"'

    # Test with String style `aria-label`
    render_inline(Primer::Beta::CloseButton.new("aria-label": "Label"))

    assert_selector("button[type='button'][aria-label='Label'].close-button")
    refute_includes rendered_content, 'aria-label="Close"'
  end

  def test_disabled
    render_inline(Primer::Beta::CloseButton.new(aria: { label: "Label" }, disabled: true))

    assert_selector("button.close-button[disabled]")
  end
end
