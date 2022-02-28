# frozen_string_literal: true

require "application_system_test_case"

class IntegrationTooltipTest < ApplicationSystemTestCase
  def test_renders_with_aria_described_by
    with_preview(:default)

    assert_selector("tool-tip[data-view-component][aria-describedby]")
  end

  def test_renders_with_aria_labelled_by
    with_preview(:label)

    assert_selector("tool-tip[data-view-component][aria-labelledby]")
  end
end
