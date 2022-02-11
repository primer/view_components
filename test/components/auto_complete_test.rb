# frozen_string_literal: true

require "test_helper"

class PrimerAutoCompleteTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_no_label_text_is_passed_in
    assert_raises ArgumentError do
      render_inline Primer::Beta::AutoComplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
        component.icon(icon: :person)
      end
    end
  end

  def test_renders_label_without_explicitly_calling_it
    render_inline Primer::Beta::AutoComplete.new(label_text: "Cool Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("label[for=\"test-input\"]", text: "Cool Fruits")
    end
  end

  def test_renders_input_without_explicitly_calling_it
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input[id=\"test-input\"].form-control")
      assert_selector("ul[id=\"my-list-id\"].autocomplete-results")
    end
  end

  def test_renders_results_without_explicitly_calling_it
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input[id=\"test-input\"].form-control")
      assert_selector("ul[id=\"my-list-id\"].autocomplete-results")
    end
  end

  def test_renders_screen_reader_label_with_icon_and_non_visible_label
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input", is_label_visible: false) do |component|
      component.icon(icon: :person)
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input.form-control")
      assert_selector("label[for=\"test-input\"]")
      assert_selector("svg.octicon.octicon-person")
      assert_selector("span.sr-only", text: "Fruits")
    end
  end

  def test_forwards_input_id_on_parent_to_input_slot_if_explicit_input_slot
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
      component.input(name: "something")
    end

    assert_selector("input[id=\"test-input\"]")
  end

  def test_forwards_input_id_on_parent_to_input_slot_id_and_name_if_explicit_input_slot
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
      component.input(classes: "")
    end

    assert_selector("input[id=\"test-input\"][name=\"test-input\"]")
  end

  def test_renders_with_icon
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input") do |component|
      component.icon(icon: :person)
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input.form-control")
      assert_selector("label[for=\"test-input\"]")
      assert_selector("svg.octicon.octicon-person")
    end
  end

  def test_renders_with_icon_and_non_visible_label
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input", is_label_visible: false) do |component|
      component.icon(icon: :person)
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input.form-control")
      assert_selector("label[for=\"test-input\"]")
      assert_selector("span.sr-only", text: "Fruits")
      assert_selector("svg.octicon.octicon-person")
    end
  end

  def test_renders_input_with_custom_classes
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input") do |component|
      component.input(classes: "custom-class")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input.form-control.custom-class")
    end
  end

  def test_renders_results_with_custom_classes
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input") do |component|
      component.results(classes: "my-class")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("ul[id=\"my-list-id\"].autocomplete-results.my-class")
    end
  end

  def test_label_becomes_screen_reader_text_if_user_sets_visibility_boolean_to_false
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id", is_label_visible: false)

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("label[for=\"test-input\"]")
      assert_selector("span.sr-only", text: "Fruits")
    end
  end
end
