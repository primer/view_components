# frozen_string_literal: true

require "test_helper"

class PrimerBetaAutoCompleteTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_no_label_text_is_passed_in
    assert_raises ArgumentError do
      render_inline Primer::Beta::AutoComplete.new(src: "/url", input_id: "test-input", list_id: "my-list-id")
    end
  end

  def test_raises_if_autofocus_added_to_input
    with_raise_on_invalid_options(true) do
      err = assert_raises ArgumentError do
        render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
          component.input(autofocus: true)
        end
      end

      assert_includes(err.message, "autofocus is not allowed for accessibility reasons")
    end
  end

  def test_raises_if_aria_label_added_to_input
    with_raise_on_invalid_aria(true) do
      err = assert_raises ArgumentError do
        render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
          component.input("aria-label": "Don't add one")
        end
      end

      assert_includes(err.message, "instead of `aria-label`, include `label_text` and set `visually_hide_label` to `true` on the component initializer.")
    end
  end

  def test_renders_label_without_explicitly_calling_it
    render_inline Primer::Beta::AutoComplete.new(label_text: "Cool Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")

    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector('label[for="test-input"]', text: "Cool Fruits")
    end
  end

  def test_renders_input_without_explicitly_calling_it
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")

    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector('input[id="test-input"].FormControl-input')
      assert_selector('ul[id="my-list-id"].ActionList')
    end
  end

  def test_renders_results_without_explicitly_calling_it
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")

    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector('input[id="test-input"].FormControl-input')
      assert_selector('ul[id="my-list-id"].ActionList')
    end
  end

  def test_forwards_input_id_on_parent_to_input
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")

    assert_selector('input[id="test-input"]')
  end

  def test_forwards_input_id_on_parent_to_input_slot_id_and_name
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id")

    assert_selector('input[id="test-input"][name="test-input"]')
  end

  def test_forwards_input_name_on_parent_to_input_slot_name
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", input_name: "test-name", list_id: "my-list-id")

    assert_selector('input[id="test-input"][name="test-name"]')
  end

  def test_renders_with_icon
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input") do |component|
      component.leading_visual_icon(icon: :search)
    end

    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector("input.FormControl-input")
      assert_selector('label[for="test-input"]')
      assert_selector("svg.FormControl-input-leadingVisual")
    end
  end

  def test_renders_non_visible_label
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input", visually_hide_label: true)

    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector("input.FormControl-input")
      assert_selector('label[for="test-input"]')
      assert_selector("label.sr-only", text: "Fruits")
    end
  end

  def test_renders_results_with_custom_classes
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", list_id: "my-list-id", input_id: "test-input") do |component|
      component.results(classes: "my-class")
    end

    assert_selector('auto-complete[for="my-list-id"][src="/url"]') do
      assert_selector('ul[id="my-list-id"].ActionList.my-class')
    end
  end

  def test_renders_clear_button_if_show_clear_button_is_true
    render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id", show_clear_button: true)

    assert_selector('button[id="test-input-clear"]')
  end

  def test_denies_id_on_input_slot
    with_raise_on_invalid_options(true) do
      err = assert_raises ArgumentError do
        render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
          component.input(id: "some-other-id")
        end
      end
      assert_includes(err.message, "`id` will always be set to @input_id.")
    end
  end

  def test_denies_name_on_input_slot
    with_raise_on_invalid_options(true) do
      err = assert_raises ArgumentError do
        render_inline Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/url", input_id: "test-input", list_id: "my-list-id") do |component|
          component.input(name: "some-other-name")
        end
      end
      assert_includes(err.message, "Set @input_name on the component initializer instead with `input_name`.")
    end
  end
end
