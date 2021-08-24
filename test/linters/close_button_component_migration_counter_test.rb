# frozen_string_literal: true

require "linter_test_case"

class CloseButtonComponentMigrationCounterTest < LinterTestCase
  include Primer::BasicLinterSharedTests

  def linter_class
    ERBLint::Linters::CloseButtonComponentMigrationCounter
  end

  def default_tag
    "button"
  end

  def default_class
    "close-button"
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

  def test_autocorrects_with_primer_octicon_class_without_aria_label
    @file = <<~HTML
      <button class="close-button" aria-label="Close menu">
        <%= render Primer::OcticonComponent(:x) %>
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

  def test_does_not_autocorrect_when_octicon_has_multiple_arguments
    @file = <<~HTML
      <button class="close-button"><%= octicon(:x, class: "custom", "aria-label": "label") %></button>
    HTML

    assert_equal "<%# erblint:counter CloseButtonComponentMigrationCounter 1 %>\n#{@file}", corrected_content
  end
end
