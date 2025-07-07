# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectPageHeaderTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector(".PageHeader")
  end

  def test_highlights_links_in_description
    visit_preview(:description)

    assert_selector(".PageHeader-description")
    assert_selector(".PageHeader-description a") do |link|
      link.assert_matches_style("text-decoration-line" => "underline")
    end
  end
end
