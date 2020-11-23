# frozen_string_literal: true

require "test_helper"

class PrimerSelectMenuItemComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::SelectMenuItemComponent.new do
      "My item"
    end

    assert_selector("button.SelectMenu-item[type='button'][role='menuitem']", text: /My item/)
  end

  def test_passes_through_extra_options
    render_inline Primer::SelectMenuItemComponent.new(
      classes: "my-item",
      role: "menuitemcheckbox",
      mt: 1,
    ) do
      "My item"
    end

    assert_selector("button.SelectMenu-item.my-item.mt-1[role='menuitemcheckbox']",
      text: /My item/)
  end

  def test_renders_as_link
    render_inline Primer::SelectMenuItemComponent.new(tag: :a, href: "#some-url") do
      "My item"
    end

    assert_selector("a.SelectMenu-item[role='menuitem'][href='#some-url']",
      text: /My item/)
  end

  def test_renders_as_div
    render_inline Primer::SelectMenuItemComponent.new(tag: :div) do
      "My item"
    end

    assert_selector("div.SelectMenu-item[role='menuitem']", text: /My item/)
  end
end
