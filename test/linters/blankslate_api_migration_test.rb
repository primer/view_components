# frozen_string_literal: true

require "linter_test_case"

class BlankslateApiMigrationTest < LinterTestCase
  def test_does_not_migrate_if_no_blankslate
    @file = "<div></div>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_migrate_when_blankslate_has_a_block
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(title: "Some title") do %>
        Custom content
      <% end %>
    ERB
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_does_not_migrate_when_blankslate_has_no_title
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new %>
    ERB

    assert_equal @file, corrected_content
  end

  def test_does_not_migrate_when_blankslate_has_both_icon_and_image
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        icon: :x,
        image_src: "image.png"
      ) %>
    ERB

    assert_equal @file, corrected_content
  end

  def test_sets_title_slot_with_h2_tag_as_default
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(title: "Some title") %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new do |c| %>
        <% c.heading(tag: :h2) do %>
          Some title
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_sets_blankslate_arguments
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        narrow: true,
        spacious: true,
        px: 3,
        display: :flex,
        "aria-label": "label"
      ) %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new(narrow: true, spacious: true, px: 3, display: :flex, "aria-label": "label") do |c| %>
        <% c.heading(tag: :h2) do %>
          Some title
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_does_not_set_large_attribute
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        large: true
      ) %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new do |c| %>
        <% c.heading(tag: :h2) do %>
          Some title
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_sets_title_slot_with_custom_tag
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        title_tag: :h3
      ) %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new do |c| %>
        <% c.heading(tag: :h3) do %>
          Some title
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_sets_description_slot
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        description: "Some description"
      ) %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new do |c| %>
        <% c.heading(tag: :h2) do %>
          Some title
        <% end %>

        <% c.description do %>
          Some description
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_sets_graphic_icon_slot
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        icon: :x,
        icon_size: :large
      ) %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new do |c| %>
        <% c.graphic_icon(icon: :x, size: :large) %>

        <% c.heading(tag: :h2) do %>
          Some title
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_sets_graphic_image_slot
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        image_src: "image.png",
        image_alt: "image alt"
      ) %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new do |c| %>
        <% c.graphic_image(src: "image.png", alt: "image alt") %>

        <% c.heading(tag: :h2) do %>
          Some title
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_sets_primary_action_slot
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        button_text: "button",
        button_url: "button url",
        button_classes: "button classes"
      ) %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new do |c| %>
        <% c.heading(tag: :h2) do %>
          Some title
        <% end %>

        <% c.primary_action(href: "button url", classes: "button classes") do %>
          button
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_sets_secondary_action_slot
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        link_text: "link",
        link_url: "link url",
      ) %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new do |c| %>
        <% c.heading(tag: :h2) do %>
          Some title
        <% end %>

        <% c.secondary_action(href: "link url") do %>
          link
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_full_with_icon
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        description: "Some description",
        icon: :x,
        icon_size: :large,
        button_text: "button",
        button_url: "button url",
        button_classes: "button classes",
        link_text: "link",
        link_url: "link url",
        narrow: true,
        spacious: true,
        px: 3,
        display: :flex,
        "aria-label": "label"
      ) %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new(narrow: true, spacious: true, px: 3, display: :flex, "aria-label": "label") do |c| %>
        <% c.graphic_icon(icon: :x, size: :large) %>

        <% c.heading(tag: :h2) do %>
          Some title
        <% end %>

        <% c.description do %>
          Some description
        <% end %>

        <% c.primary_action(href: "button url", classes: "button classes") do %>
          button
        <% end %>

        <% c.secondary_action(href: "link url") do %>
          link
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_full_with_image
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new(
        title: "Some title",
        description: "Some description",
        image_src: "image.png",
        image_alt: "image alt",
        button_text: "button",
        button_url: "button url",
        button_classes: "button classes",
        link_text: "link",
        link_url: "link url",
        narrow: true,
        spacious: true,
        px: 3,
        display: :flex,
        "aria-label": "label"
      ) %>
    ERB

    expected = <<~ERB
      <%= render Primer::Beta::Blankslate.new(narrow: true, spacious: true, px: 3, display: :flex, "aria-label": "label") do |c| %>
        <% c.graphic_image(src: "image.png", alt: "image alt") %>

        <% c.heading(tag: :h2) do %>
          Some title
        <% end %>

        <% c.description do %>
          Some description
        <% end %>

        <% c.primary_action(href: "button url", classes: "button classes") do %>
          button
        <% end %>

        <% c.secondary_action(href: "link url") do %>
          link
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  private

  def linter_class
    ERBLint::Linters::BlankslateApiMigration
  end
end
