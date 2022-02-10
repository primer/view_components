# frozen_string_literal: true

require "application_system_test_case"

class IntegrationTooltipTest < ApplicationSystemTestCase
  def test_renders_with_aria_described_by
    with_preview(:default)

    assert_selector("primer-tooltip[data-view-component]")
  end

  def test_renders_with_aria_labelled_by
    with_preview(:label)

    assert_selector("primer-tooltip[data-view-component][aria-labelledby]")
  end
end
