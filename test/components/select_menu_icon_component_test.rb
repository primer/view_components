# frozen_string_literal: true

require "test_helper"

class PrimerSelectMenuIconComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::SelectMenuIconComponent.new
    assert_selector(".SelectMenu-icon.SelectMenu-icon--check.octicon.octicon-check")
  end

  def test_passes_through_extra_options
    render_inline Primer::SelectMenuIconComponent.new(
      classes: "my-icon",
      icon: "star",
      mt: 1,
    )

    assert_selector(".SelectMenu-icon.SelectMenu-icon--check.octicon." \
      "octicon-star.my-icon.mt-1")
  end
end
