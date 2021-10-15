# frozen_string_literal: true

require "test_helper"

class PrimerAlphaMarkdownToolbarTest < Minitest::Test
  include Primer::ComponentTestHelpers

  TEXTAREA_ID = "#some-example-textarea"

  def test_renders_toolbar
    render_inline(Primer::MarkdownToolbar.new(textarea_id: TEXTAREA_ID))

    assert_selector("button[aria-label='Toggle text tools']")
    
  end

  def test_renders_toolbar_with_prepend_buttons

  end

  def test_renders_toolbar_with_append_buttons

  end
end
