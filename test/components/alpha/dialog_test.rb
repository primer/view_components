# frozen_string_literal: true

require "test_helper"

class PrimerAlphaDialogTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |c|
      c.body { "content" }
    end

    assert_selector("div[role='dialog']") do
      assert_selector("div", text: "content")
    end
  end

  # Displays rich content in body

  # Complain about missing title

  # Sets title

  # Doesn't add description if not present

  # Sets description if present

  # Doesn't add buttons if not present

  # Adds buttons if present
end
