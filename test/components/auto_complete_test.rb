# frozen_string_literal: true

require "test_helper"

class PrimerAutoCompleteTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_no_input_is_defined
    assert_raises ArgumentError do
      render_inline Primer::AutoComplete.new(src: "/url", id: "my-id") do |component|
        component.icon(icon: :person)
      end
    end
  end

  def test_renders_results_without_explicitly_calling_it
    render_inline Primer::AutoComplete.new(src: "/url", id: "my-id") do |component|
      component.label(for: "test-input").with_content("Hello")
      component.input(id: "test-input", name: "input")
    end

    assert_selector("auto-complete[for=\"my-id\"][src=\"/url\"]") do
      assert_selector("label[for=\"test-input\"]")
      assert_selector("input[id=\"test-input\"].form-control")
      assert_selector("ul[id=\"my-id\"].autocomplete-results")
    end
  end

  def test_applies_parent_aria_label_on_relevant_child_slots
    render_inline Primer::AutoComplete.new(src: "/url", id: "my-id", "aria-label": "Fruits") do |component|
      component.input(name: "input")
    end

    assert_selector("auto-complete[for=\"my-id\"][src=\"/url\"]") do
      assert_selector("input[aria-label=\"Fruits\"]")
      assert_selector("ul[id=\"my-id\"][aria-label=\"Fruits\"]")
    end
  end

  def test_overrides_parent_aria_label_if_also_set_on_slot
    render_inline Primer::AutoComplete.new(src: "/url", id: "my-id", "aria-label": "Fruits") do |component|
      component.input("aria-label": "Select your favorite fruit", name: "input")
      component.results("aria-label": "Fruits!")
    end

    assert_selector("auto-complete[for=\"my-id\"][src=\"/url\"]") do
      assert_selector("input[aria-label=\"Select your favorite fruit\"]")
      assert_selector("ul[id=\"my-id\"][aria-label=\"Fruits!\"]")
    end
  end

  def test_raises_if_missing_for_keyword_on_label_slot
    err = assert_raises ArgumentError do
      render_inline Primer::AutoComplete.new(src: "/url", id: "my-id") do |component|
        component.label(id: "test-label")
        component.input(id: "test-input", name: "input")
      end
    end

    assert_equal("missing keyword: for", err.message)
  end

  def test_raises_if_no_label_or_aria_label_provided_for_input
    err = assert_raises ArgumentError do
      render_inline Primer::AutoComplete.new(src: "/url", id: "my-id") do |component|
        component.input(name: "input")
      end
    end

    assert_equal("Accessible label is required.", err.message)
  end

  def test_renders_with_icon
    render_inline Primer::AutoComplete.new(src: "/url", id: "my-id", "aria-label": "Fruits") do |component|
      component.input(name: "input")
      component.icon(icon: :person)
    end

    assert_selector("auto-complete[for=\"my-id\"][src=\"/url\"]") do
      assert_selector("input[aria-label=\"Fruits\"].form-control")
      assert_selector("svg.octicon.octicon-person")
    end
  end

  def test_renders_results_with_custom_classes
    render_inline Primer::AutoComplete.new(src: "/url", id: "my-id", "aria-label": "Fruits") do |component|
      component.input(classes: "custom-class")
      component.results(classes: "my-class")
    end

    assert_selector("auto-complete[for=\"my-id\"][src=\"/url\"]") do
      assert_selector("input[aria-label=\"Fruits\"].custom-class")
      assert_selector("ul[id=\"my-id\"][aria-label=\"Fruits\"].autocomplete-results.my-class")
    end
  end
end
