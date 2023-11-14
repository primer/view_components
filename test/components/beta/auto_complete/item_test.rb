# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaAutoCompleteItemTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_item_with_correct_attributes
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo")) { "Item" }

    assert_selector("[role=\"option\"][data-autocomplete-value=\"foo\"].ActionListItem", text: "Item")
  end

  def test_renders_selected_item
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo", selected: true)) { "Item" }

    assert_selector("[role=\"option\"][data-autocomplete-value=\"foo\"][aria-selected=\"true\"].ActionListItem", text: "Item")
  end

  def test_renders_disabled_item
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo", disabled: true)) { "Item" }

    assert_selector("[role=\"option\"][data-autocomplete-value=\"foo\"][aria-disabled=\"true\"].ActionListItem", text: "Item")
  end

  def test_renders_with_leading_visual_icon
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo", disabled: false)) do |component|
      component.with_leading_visual_icon(icon: :search)
      "Item text"
    end

    assert_selector("[role=\"option\"][data-autocomplete-value=\"foo\"].ActionListItem", text: "Item text") do
      assert_selector("span.ActionListContent") do
        assert_selector("span.ActionListItem-visual.ActionListItem-visual--leading")
      end
    end
  end

  def test_renders_with_leading_visual_avatar
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo", disabled: false)) do |component|
      component.with_leading_visual_avatar(src: "https://github.com/github.png", alt: "github")
      "Item text"
    end

    assert_selector("[role=\"option\"][data-autocomplete-value=\"foo\"].ActionListItem", text: "Item text") do
      assert_selector("span.ActionListContent") do
        assert_selector("span.ActionListItem-visual.ActionListItem-visual--leading")
      end
    end
  end

  def test_renders_with_trailing_visual
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo", disabled: false)) do |component|
      component.with_trailing_visual_icon(icon: :search)
      "Item text"
    end

    assert_selector("[role=\"option\"][data-autocomplete-value=\"foo\"].ActionListItem", text: "Item text") do
      assert_selector("span.ActionListContent") do
        assert_selector("span.ActionListItem-visual.ActionListItem-visual--trailing")
      end
    end
  end

  def test_renders_with_description
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo", disabled: false)) do |component|
      component.with_description { "Item description" }
      "Item text"
    end

    assert_selector("[role=\"option\"][data-autocomplete-value=\"foo\"].ActionListItem", text: "Item text") do
      assert_selector("span.ActionListContent") do
        assert_selector("span.ActionListItem-descriptionWrap") do
          assert_selector("span.ActionListItem-description", text: "Item description")
        end
      end
    end
  end

  def test_renders_with_inline_description
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo", disabled: false, description_variant: :inline)) do |component|
      component.with_description { "Item description" }
      "Item text"
    end

    assert_selector("[role=\"option\"][data-autocomplete-value=\"foo\"].ActionListItem", text: "Item text") do
      assert_selector("span.ActionListContent") do
        assert_selector("span.ActionListItem-descriptionWrap.ActionListItem-descriptionWrap--inline")
      end
    end
  end
end
