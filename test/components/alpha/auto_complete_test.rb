# frozen_string_literal: true

require "test_helper"

class PrimerAlphaAutoCompleteTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_no_label_text_is_passed_in
    assert_raises ArgumentError do
      render_inline Primer::Alpha::AutoComplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
        component.icon(icon: :person)
      end
    end
  end

  def test_raises_if_autofocus_added_to_input
    with_raise_on_invalid_options(true) do
      err = assert_raises ArgumentError do
        render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
          component.input(autofocus: true)
          component.icon(icon: :person)
        end
      end
      assert_includes(err.message, "autofocus is not allowed for accessibility reasons")
    end
  end

  def test_raises_if_aria_label_added_to_input
    with_raise_on_invalid_aria(true) do
      err = assert_raises ArgumentError do
        render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
          component.input("aria-label": "Don't add one")
          component.icon(icon: :person)
        end
      end
      assert_includes(err.message, "instead of `aria-label`, include `label_text` and set `is_label_visible` to `false` on the component initializer.")
    end
  end

  def test_renders_label_without_explicitly_calling_it
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Cool Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")
    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector('label[for="test-input"]', text: "Cool Fruits")
    end
  end

  def test_renders_input_without_explicitly_calling_it
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")
    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector('input[id="test-input"].form-control')
      assert_selector('ul[id="my-list-id"].autocomplete-results')
    end
  end

  def test_renders_results_without_explicitly_calling_it
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")
    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector('input[id="test-input"].form-control')
      assert_selector('ul[id="my-list-id"].autocomplete-results')
    end
  end

  def test_forwards_input_id_on_parent_to_input
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")
    assert_selector('input[id="test-input"]')
  end

  def test_forwards_input_id_on_parent_to_input_slot_id_and_name
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")
    assert_selector('input[id="test-input"][name="test-input"]')
  end

  def test_forwards_input_name_on_parent_to_input_slot_name
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", input_name: "test-name", list_id: "my-list-id")
    assert_selector('input[id="test-input"][name="test-name"]')
  end

  def test_renders_with_icon
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input", with_icon: true)
    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector("input.form-control")
      assert_selector('label[for="test-input"]')
      assert_selector("svg.octicon.octicon-search")
    end
  end

  def test_renders_screen_reader_label_with_icon_and_non_visible_label
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input", is_label_visible: false, with_icon: true)
    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector("input.form-control")
      assert_selector('label[for="test-input"]')
      assert_selector("svg.octicon.octicon-search")
      assert_selector("span.sr-only", text: "Fruits")
    end
  end

  def test_wraps_icon_and_input_when_with_icon_true
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Cool Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id", with_icon: true)
    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector("div.form-control.autocomplete-embedded-icon-wrap")
      assert_selector("input.form-control")
      assert_selector("svg.octicon.octicon-search")
    end
  end

  def test_does_not_contain_wrapper_if_no_icon
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Cool Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")
    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      refute_selector("div.form-control.autocomplete-embedded-icon-wrap")
      assert_selector('label[for="test-input"]')
      assert_selector("input.form-control")
    end
  end

  def test_applies_default_stacked_label_class
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Cool Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")
    assert_selector("label.autocomplete-label-stacked")
  end

  def test_applies_correct_class_when_is_label_inline
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Cool Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id", is_label_inline: true)
    assert_selector("label.autocomplete-label-inline")
  end

  def test_applies_correct_class_when_is_label_visible_is_false
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Cool Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id", is_label_visible: false)
    refute_selector("label.autocomplete-label-inline")
  end

  def test_renders_results_with_custom_classes
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input") do |component|
      component.results(classes: "my-class")
    end
    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector('ul[id="my-list-id"].autocomplete-results.my-class')
    end
  end

  def test_label_becomes_screen_reader_text_if_user_sets_visibility_boolean_to_false
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id", is_label_visible: false)
    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector('label[for="test-input"]')
      assert_selector("span.sr-only", text: "Fruits")
    end
  end

  def test_renders_clear_button_if_is_clearable_is_true
    render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id", is_clearable: true)
    assert_selector('button[id="test-input-clear"]')
  end

  def test_denies_id_on_input_slot
    with_raise_on_invalid_options(true) do
      err = assert_raises ArgumentError do
        render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
          component.input(id: "some-other-id")
        end
      end
      assert_includes(err.message, "`id` will always be set to @input_id.")
    end
  end

  def test_denies_name_on_input_slot
    with_raise_on_invalid_options(true) do
      err = assert_raises ArgumentError do
        render_inline Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
          component.input(name: "some-other-name")
        end
      end
      assert_includes(err.message, "Set @input_name on the component initializer instead with `input_name`.")
    end
  end
end
