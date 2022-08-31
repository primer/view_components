# frozen_string_literal: true

require "test_helper"

class PrimerBetaIconButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Beta::IconButton.new(icon: :star, "aria-label": "Star"))

    assert_selector(".Button.Button--iconOnly") do
      assert_selector(".Button-visual")
    end
    assert_selector("tool-tip", text: "Star", visible: :all)
  end
end
