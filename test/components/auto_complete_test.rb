# frozen_string_literal: true

# TODO
# Keep aria-labelledby functionality
# Remove passed in input
# with icon and non-visible label

require "test_helper"

class PrimerAutoCompleteTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_no_input_is_defined
    assert_raises ArgumentError do
      render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
        component.icon(icon: :person)
      end
    end
  end

  def test_raises_if_no_label_text_is_passed_in
    assert_raises ArgumentError do
      render_inline Primer::Beta::AutoComplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
        component.icon(icon: :person)
      end
    end
  end

  def test_renders_results_without_explicitly_calling_it
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
      component.input(id: "test-input", name: "input")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input[id=\"test-input\"].form-control")
      assert_selector("ul[id=\"my-list-id\"].autocomplete-results")
    end
  end

  def test_renders_label_without_explicitly_calling_it
    render_inline Primer::Beta::AutoComplete.new(label_text: "Cool Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
      component.input(id: "test-input", name: "input")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("label[for=\"test-input\"]", text: "Cool Fruits")
    end
  end

  def test_forwards_input_id_on_parent_to_input_slot_id
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
      component.input(name: "something")
    end

    assert_selector("input[id=\"test-input\"]")
  end

  def test_forwards_input_id_on_parent_to_input_slot_id_and_name
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
      component.input(classes: "")
    end

    assert_selector("input[id=\"test-input\"][name=\"test-input\"]")
  end

  # # def test_applies_parent_aria_label_on_relevant_child_slots
  # #   render_inline Primer::Beta::AutoComplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id", "aria-label": "Fruits") do |component|
  # #     component.input(name: "input")
  # #   end

  # #   assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
  # #     assert_selector("input[aria-label=\"Fruits\"]")
  # #     assert_selector("ul[id=\"my-list-id\"][aria-label=\"Fruits\"]")
  # #   end
  # # end

  # # def test_overrides_parent_aria_label_if_also_set_on_slot
  # #   render_inline Primer::Beta::AutoComplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id", "aria-label": "Fruits") do |component|
  # #     component.input("aria-label": "Select your favorite fruit", name: "input")
  # #     component.results("aria-label": "Fruits!")
  # #   end

  # #   assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
  # #     assert_selector("input[aria-label=\"Select your favorite fruit\"]")
  # #     assert_selector("ul[id=\"my-list-id\"][aria-label=\"Fruits!\"]")
  # #   end
  # # end

  # TODO: aria-hidden="true" on icon
  def test_renders_with_icon
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input") do |component|
      component.input(name: "input")
      component.icon(icon: :person)
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input.form-control")
      assert_selector("svg.octicon.octicon-person")
    end
  end

  def test_renders_results_with_custom_classes
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input") do |component|
      component.input(classes: "custom-class")
      component.results(classes: "my-class")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input.custom-class.form-control")
      assert_selector("ul[id=\"my-list-id\"].autocomplete-results.my-class")
    end
  end

  def test_do_not_allow_aria_label
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input", "aria-label": "Super fruits") do |component|
      component.input(classes: "custom-class")
      component.results(classes: "my-class")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("input.custom-class.form-control")
      # TODO: Make sure this fails
      refute_selector("input[aria-label='Super Fruits']")
      assert_selector("label[for=\"test-input\"]", text: "Fruits")
    end
  end

  def test_label_becomes_screen_reader_text_if_user_sets_visibility_boolean_to_false
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id", is_label_visible: false) do |component|
      component.input(id: "test-input", name: "input")
    end

    assert_selector("auto-complete[for=\"my-list-id\"][src=\"/url\"]") do
      assert_selector("label[for=\"test-input\"]")
      assert_selector("span.sr-only", text: "Fruits")
    end
  end
end
