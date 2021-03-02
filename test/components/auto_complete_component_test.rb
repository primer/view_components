# frozen_string_literal: true

require "test_helper"

class PrimerAutoCompleteComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_no_input_is_defined
    assert_raises ArgumentError do
      render_inline Primer::AutoCompleteComponent.new(src: "/url", id: "my-id") do |component|
        component.icon(icon: :person)
      end
    end
  end

  def test_renders_results_without_explicitly_calling_it
    render_inline Primer::AutoCompleteComponent.new(src: "/url", id: "my-id") do |component|
      component.input(classes: "form-control")
    end

    assert_selector("auto-complete[for=\"my-id\"][src=\"/url\"]") do
      assert_selector("input.form-control")
      assert_selector("ul[id=\"my-id\"].autocomplete-results")
    end
  end

  def test_renders_with_icon
    render_inline Primer::AutoCompleteComponent.new(src: "/url", id: "my-id") do |component|
      component.input(classes: "form-control")
      component.icon(icon: :person)
    end

    assert_selector("auto-complete[for=\"my-id\"][src=\"/url\"]") do
      assert_selector("input.form-control")
      assert_selector("svg.octicon.octicon-person")
      assert_selector("ul[id=\"my-id\"].autocomplete-results")
    end
  end

  def test_renders_results_with_custom_classes
    render_inline Primer::AutoCompleteComponent.new(src: "/url", id: "my-id") do |component|
      component.input(classes: "form-control")
      component.results(classes: "my-class")
    end

    assert_selector("auto-complete[for=\"my-id\"][src=\"/url\"]") do
      assert_selector("input.form-control")
      assert_selector("ul[id=\"my-id\"].autocomplete-results.my-class")
    end
  end
end
