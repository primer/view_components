# frozen_string_literal: true

require "lib/erblint_test_case"

class CloseButtonComponentMigrationCounterTest < ErblintTestCase
  include Primer::BasicLinterSharedTests
  include Primer::AutocorrectableLinterSharedTests

  def linter_class
    ERBLint::Linters::CloseButtonComponentMigrationCounter
  end

  def test_autocorrects_using_primer_octicon_aria_label
    @file = <<~HTML
      <button class="close-button"><%= primer_octicon(:x, "aria-label": "Close menu") %></button>
    HTML

    expected = <<~HTML
      <%= render Primer::Beta::CloseButton.new(\"aria-label\": \"Close menu\") %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_using_octicon_aria_label
    @file = <<~HTML
      <button class="close-button"><%= octicon(:x, "aria-label": "Close menu") %></button>
    HTML

    expected = <<~HTML
      <%= render Primer::Beta::CloseButton.new(\"aria-label\": \"Close menu\") %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_using_primer_octicon_hash_aria_label
    @file = <<~HTML
      <button class="close-button"><%= primer_octicon(:x, aria: { label: "Close menu" }) %></button>
    HTML

    expected = <<~HTML
      <%= render Primer::Beta::CloseButton.new(\"aria-label\": \"Close menu\") %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_using_primer_octicon_class_aria_label
    @file = <<~HTML
      <button class="close-button">
        <%= render Primer::Beta::Octicon(icon: :x, aria: { label: "Close menu" }) %>
      </button>
    HTML

    expected = <<~HTML
      <%= render Primer::Beta::CloseButton.new(\"aria-label\": \"Close menu\") %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_with_primer_octicon_class_without_aria_label
    @file = <<~HTML
      <button class="close-button" aria-label="Close menu">
        <%= render Primer::Beta::Octicon(:x) %>
      </button>
    HTML

    expected = <<~HTML
      <%= render Primer::Beta::CloseButton.new(\"aria-label\": \"Close menu\") %>
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

  def test_does_not_autocorrect_with_unknown_erb_call
    @file = <<~HTML
      <button class="close-button"><%= some_call %></button>
    HTML

    assert_equal "<%# erblint:counter CloseButtonComponentMigrationCounter 1 %>\n#{@file}", corrected_content
  end

  def test_autocorrects_mixing_button_args_and_octicon_aria_label
    @file = <<~HTML
      <button class="close-button ml-1" aria-value="some value"><%= primer_octicon(:x, "aria-label": "Close menu") %></button>
    HTML

    expected = <<~HTML
      <%= render Primer::Beta::CloseButton.new(ml: 1, \"aria-value\": \"some value\", \"aria-label\": \"Close menu\") %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_does_not_autocorrect_with_custom_octicon
    @file = <<~HTML
      <button class="close-button" aria-label="label"><%= octicon(:icon) %></button>
    HTML

    assert_equal "<%# erblint:counter CloseButtonComponentMigrationCounter 1 %>\n#{@file}", corrected_content
  end

  def test_does_not_autocorrect_with_custom_primer_octicon
    @file = <<~HTML
      <button class="close-button" aria-label="label"><%= primer_octicon(:icon) %></button>
    HTML

    assert_equal "<%# erblint:counter CloseButtonComponentMigrationCounter 1 %>\n#{@file}", corrected_content
  end

  def test_does_not_autocorrect_with_custom_primer_octicon_class
    @file = <<~HTML
      <button class="close-button" aria-label="label"><%= render Primer::Beta::Octicon.new(:icon) %></button>
    HTML

    assert_equal "<%# erblint:counter CloseButtonComponentMigrationCounter 1 %>\n#{@file}", corrected_content
  end

  def test_does_not_autocorrect_with_custom_primer_octicon_class_with_kwargs
    @file = <<~HTML
      <button class="close-button" aria-label="label"><%= render Primer::Beta::Octicon.new(icon: :icon) %></button>
    HTML

    assert_equal "<%# erblint:counter CloseButtonComponentMigrationCounter 1 %>\n#{@file}", corrected_content
  end

  private

  def default_tag
    "button"
  end

  def default_class
    "close-button"
  end

  def default_content
    "<%= primer_octicon(:x) %>"
  end

  def required_attributes
    'aria-label="label"'
  end

  def required_arguments
    "\"aria-label\": \"label\""
  end

  def block_correction?
    false
  end
end
