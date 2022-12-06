# frozen_string_literal: true

require "system/test_case"

class IntegrationAlphaLocalTimeTest < System::TestCase
  def test_default
    visit_preview(:default)

    assert_selector("relative-time[data-view-component][prefix='']")
  end

  def test_with_all_the_options
    visit_preview(:with_all_the_options)

    assert_selector("relative-time[data-view-component][prefix=''][year='2-digit'][month='long']")
  end

  def test_with_contents
    visit_preview(:with_contents)

    assert_selector("relative-time[data-view-component][prefix='']")
  end
end
