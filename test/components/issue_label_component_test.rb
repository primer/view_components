# frozen_string_literal: true

require "test_helper"

class PrimerIssueLabelComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::IssueLabelComponent.new) { "private" }

    assert_selector(".IssueLabel", text: "private")
  end

  def test_renders_big_variant
    render_inline(Primer::IssueLabelComponent.new(variant: :big)) { "private" }

    assert_selector(".IssueLabel.IssueLabel--big", text: "private")
  end
end
