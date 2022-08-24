# frozen_string_literal: true

require "test_helper"

class PrimerAlphaAutoCompleteItemTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_item_with_correct_attributes
    render_inline(Primer::Alpha::AutoComplete::Item.new(value: "foo")) { "Item" }
    assert_selector("li[role=\"option\"][data-autocomplete-value=\"foo\"].autocomplete-item", text: "Item")
  end

  def test_renders_selected_item
    render_inline(Primer::Alpha::AutoComplete::Item.new(value: "foo", selected: true)) { "Item" }
    assert_selector("li[role=\"option\"][data-autocomplete-value=\"foo\"][aria-selected=\"true\"].autocomplete-item", text: "Item")
  end

  def test_renders_disabled_item
    render_inline(Primer::Alpha::AutoComplete::Item.new(value: "foo", disabled: true)) { "Item" }
    assert_selector("li[role=\"option\"][data-autocomplete-value=\"foo\"][aria-disabled=\"true\"].autocomplete-item.disabled", text: "Item")
  end
end
