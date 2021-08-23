# frozen_string_literal: true

require "linter_test_case"

class CloseButtonComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::CloseButtonComponentMigrationCounter
  end

  def test_warns_if_there_is_a_html_close_button
    @file = "<button class=\"close-button\">close-button</button>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_suggests_ignoring_with_correct_number_of_close_buttons
    @file = "<button class=\"close-button\">close-button</button><button class=\"close-button\">close-button</button><button class=\"not-a-close-button\">close-button</button>"

    assert_equal "<%# erblint:counter CloseButtonComponentMigrationCounter 2 %>\n#{@file}", corrected_content
  end

  def test_does_not_warn_if_wrong_tag
    @file = "<div class=\"close_button\">close-button</div>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_autocorrects_with_primer_octicon
    @file = <<~HTML
      <button class="close-button"><%= primer_octicon(:x, "aria-label": "Close menu") %></button>
    HTML

    expected = <<~HTML
      <%= render Primer::CloseButton.new(\"aria-label\": \"Close menu\") %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_with_aria_label
    @file = <<~HTML
      <button class="close-button" aria-label="Close menu"><%= primer_octicon(:x) %></button>
    HTML

    expected = <<~HTML
      <%= render Primer::CloseButton.new(\"aria-label\": \"Close menu\") %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_with_octicon
    @file = <<~HTML
      <button class="close-button"><%= octicon(:x, "aria-label": "Close menu") %></button>
    HTML

    expected = <<~HTML
      <%= render Primer::CloseButton.new(\"aria-label\": \"Close menu\") %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_with_primer_octicon_hash_aria_label
    @file = <<~HTML
      <button class="close-button"><%= primer_octicon(:x, aria: { label: "Close menu" }) %></button>
    HTML

    expected = <<~HTML
      <%= render Primer::CloseButton.new(\"aria-label\": \"Close menu\") %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_with_primer_octicon_class
    @file = <<~HTML
      <button class="close-button">
        <%= render Primer::OcticonComponent(icon: :x, aria: { label: "Close menu" }) %>
      </button>
    HTML

    expected = <<~HTML
      <%= render Primer::CloseButton.new(\"aria-label\": \"Close menu\") %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_does_not_autocorrect_without_octicon
    @file = <<~HTML
      <button class="close-button" aria-label="label">some other content</button>
    HTML

    assert_equal "<%# erblint:counter CloseButtonComponentMigrationCounter 1 %>\n#{@file}", corrected_content
  end

  def test_does_not_autocorrect_without_aria_label
    @file = <<~HTML
      <button class="close-button"><%= octicon(:x) %></button>
    HTML

    assert_equal "<%# erblint:counter CloseButtonComponentMigrationCounter 1 %>\n#{@file}", corrected_content
  end
end
