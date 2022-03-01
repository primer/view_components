# frozen_string_literal: true

require "application_system_test_case"

class IntegrationTooltipTest < ApplicationSystemTestCase
  def test_renders_with_aria_described_by
    with_preview(:description)

    assert_selector("button[id='dislike-button']")
    assert_selector("tool-tip[for='dislike-button'][data-view-component][role='tooltip']", visible: false, text: "This means you dislike this comment")
    assert_equal(find("button")["aria-describedby"], find("tool-tip", visible: false)["id"])
  end

  def test_renders_with_aria_labelled_by
    with_preview(:label)

    assert_selector("button[id='like-button']")
    assert_selector("tool-tip[for='like-button'][data-view-component]", visible: false, text: "Like")
    assert_equal(find("button")["aria-labelledby"], find("tool-tip", visible: false)["id"])
  end
end
