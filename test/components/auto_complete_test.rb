# frozen_string_literal: true

require "test_helper"

class PrimerAutocompleteTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_no_input_is_defined
    assert_raises ArgumentError do
      render_inline Primer::Beta::Autocomplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
        component.icon(icon: :person)
      end
    end
  end

  def test_renders_results_without_explicitly_calling_it
    render_inline Primer::Beta::Autocomplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
      component.label(classes: "")
      component.input(id: "test-input", name: "input")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("label[for=\"test-input\"]")
      assert_selector("input[id=\"test-input\"].form-control")
      assert_selector("ul[id=\"my-list-id\"].autocomplete-results")
    end
  end

  def test_forwards_input_id_on_parent_to_input_slot_id
    render_inline Primer::Beta::Autocomplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
      component.label(classes: "") { "Fruits" }
      component.input(name: "something")
    end

    assert_selector("input[id=\"test-input\"]")
  end

  def test_forwards_input_id_on_parent_to_input_slot_id_and_name
    render_inline Primer::Beta::Autocomplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
      component.label(classes: "") { "Fruits" }
      component.input(classes: "")
    end

    assert_selector("input[id=\"test-input\"][name=\"test-input\"]")
  end

  def test_applies_parent_aria_label_on_relevant_child_slots
    render_inline Primer::Beta::Autocomplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id", "aria-label": "Fruits") do |component|
      component.input(name: "input")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input[aria-label=\"Fruits\"]")
      assert_selector("ul[id=\"my-list-id\"][aria-label=\"Fruits\"]")
    end
  end

  def test_overrides_parent_aria_label_if_also_set_on_slot
    render_inline Primer::Beta::Autocomplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id", "aria-label": "Fruits") do |component|
      component.input("aria-label": "Select your favorite fruit", name: "input")
      component.results("aria-label": "Fruits!")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input[aria-label=\"Select your favorite fruit\"]")
      assert_selector("ul[id=\"my-list-id\"][aria-label=\"Fruits!\"]")
    end
  end

  def test_raises_if_no_label_or_aria_label_or_aria_labelled_by_provided_for_input
    err = assert_raises ArgumentError do
      render_inline Primer::Beta::Autocomplete.new(src: "/url", list_id: "my-list-id", input_id: "test-input") do |component|
        component.input(name: "input")
      end
    end

    assert_equal("Accessible label is required.", err.message)
  end

  def test_renders_with_icon
    render_inline Primer::Beta::Autocomplete.new(src: "/url", list_id: "my-list-id", "aria-label": "Fruits", input_id: "test-input") do |component|
      component.input(name: "input")
      component.icon(icon: :person)
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input[aria-label=\"Fruits\"].form-control")
      assert_selector("svg.octicon.octicon-person")
    end
  end

  def test_renders_results_with_custom_classes
    render_inline Primer::Beta::Autocomplete.new(src: "/url", list_id: "my-list-id", "aria-label": "Fruits", input_id: "test-input") do |component|
      component.input(classes: "custom-class")
      component.results(classes: "my-class")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input[aria-label=\"Fruits\"].custom-class.form-control")
      assert_selector("ul[id=\"my-list-id\"][aria-label=\"Fruits\"].autocomplete-results.my-class")
    end
  end
end
