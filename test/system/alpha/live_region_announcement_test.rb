# frozen_string_literal: true

require "system/test_case"

class IntegrationAlphaLiveRegionAnnouncementTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector("live-region")
  end

  def test_populates_polite_live_region
    visit_preview(:with_button_to_announce)

    assert_equal page.evaluate_script("document.querySelector('live-region').shadowRoot.querySelector('[aria-live=\"polite\"]').innerText"), ""

    find("#announce-polite-button").click

    assert_equal page.evaluate_script("document.querySelector('live-region').shadowRoot.querySelector('[aria-live=\"polite\"]').innerText"), "I am a polite announcement."
  end

  def test_populates_assertive_live_region
    visit_preview(:with_button_to_announce)

    assert_equal page.evaluate_script("document.querySelector('live-region').shadowRoot.querySelector('[aria-live=\"assertive\"]').innerText"), ""

    find("#announce-assertive-button").click

    assert_equal page.evaluate_script("document.querySelector('live-region').shadowRoot.querySelector('[aria-live=\"assertive\"]').innerText"), "I am an assertive announcement!"
  end
end
