# frozen_string_literal: true

require "lib/test_helper"
require_relative "forms/form_test_component"

class Primer::FormsTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_custom_width_fields
    render_inline Primer::FormTestComponent.new(form_class: CustomWidthFieldsForm)

    assert_selector "div.FormControl-input-width--medium"
    assert_selector "div.FormControl-input-width--small"
  end

  def test_renders_correct_form_structure
    render_preview :single_text_field_form

    assert_selector "form[action='/foo'] .FormControl" do
      assert_selector "label[for='ultimate_answer']", text: "Ultimate answer" do
        # asterisk for required field
        assert_selector "span[aria-hidden='true']", text: "*"
      end

      assert_selector "input[type='text'][name='ultimate_answer'][id='ultimate_answer'][aria-required='true']"
    end
  end

  def test_renders_correct_form_structure_inside_a_component
    render_inline Primer::FormTestComponent.new(form_class: SingleTextFieldForm)

    assert_selector "form[action='/foo'] .FormControl" do
      assert_selector "label[for='ultimate_answer']", text: "Ultimate answer" do
        # asterisk for required field
        assert_selector "span[aria-hidden='true']", text: "*"
      end

      assert_selector "input[type='text'][name='ultimate_answer'][id='ultimate_answer'][aria-required='true']"
    end
  end

  def test_renders_correct_form_structure_for_a_checkbox
    render_preview :text_field_and_checkbox_form

    assert_selector "input[type='checkbox'][name='enable_ipd'][id='enable_ipd']"
    assert_selector "label[for='enable_ipd']", text: "Enable the Infinite Improbability Drive" do
      assert_selector ".FormControl-caption", text: "Cross interstellar distances in a mere nothingth of a second."
    end
  end

  def test_includes_the_given_caption
    render_preview :single_text_field_form

    assert_selector ".FormControl-caption", text: "The answer to life, the universe, and everything"
  end

  def test_the_input_is_described_by_the_caption
    render_preview :single_text_field_form

    caption_id = page.find_all(".FormControl-caption").first["id"]
    assert_selector "input[aria-describedby*='#{caption_id}']"
  end

  def test_renders_the_caption_template_when_present
    render_preview :caption_template_form

    assert_selector ".FormControl-caption .color-fg-danger", text: "Be honest!"
    assert_selector ".FormControl-caption .color-fg-danger", text: "Check only if you are cool."
    assert_selector ".FormControl-caption .color-fg-danger", text: "A young thing."
    assert_selector ".FormControl-caption .color-fg-danger", text: "No longer a spring chicken."
  end

  def test_the_input_is_described_by_the_caption_when_caption_templates_are_used
    num_inputs = 4
    render_preview :caption_template_form

    caption_ids = page
                  .find_all("span.FormControl-caption")
                  .map { |caption| caption["id"] }
                  .reject(&:empty?)
                  .uniq

    assert caption_ids.size == num_inputs, "Expected #{num_inputs} unique caption IDs, got #{caption_ids.size}"

    assert_selector("input", count: num_inputs) do |input|
      caption_id = input["aria-describedby"].split.find { |id| id.start_with?("caption-") }
      assert_includes caption_ids, caption_id
      caption_ids.delete(caption_id)
    end

    assert_empty caption_ids
  end

  def test_renders_content_after_the_form_when_present
    render_preview :after_content_form

    assert_selector ".content-after"
  end

  def test_raises_an_error_if_both_a_caption_argument_and_a_caption_template_are_provided
    error = assert_raises RuntimeError do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render(BothTypesOfCaptionForm.new(f))
        end
      end
    end

    assert_includes error.message, "Please provide either a caption: argument or caption template"
  end

  def test_form_list_renders_multiple_forms
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(Primer::Forms::FormList.new(FirstNameForm.new(f), LastNameForm.new(f)))
      end
    end

    assert_selector "input[type=text][name=first_name]"
    assert_selector "input[type=text][name=last_name]"
  end

  def test_renders_buttons
    render_preview :submit_button_form

    assert_selector "button[type=submit]"
    assert_selector "button[type=button]"
  end

  def test_buttons_are_not_described_by_validation_ids
    render_preview :submit_button_form

    refute_selector "button[aria-describedby]"
  end

  def test_renders_buttons_with_slots
    render_preview :submit_button_form

    assert_selector "button[type=submit]" do
      assert_selector ".octicon-check-circle"
    end

    assert_selector "button[type=button]" do
      assert_selector ".octicon-alert"
    end
  end

  def test_renders_buttons_with_primer_utility_margins
    render_preview :submit_button_form

    assert_selector "button.mb-3[type=submit]"
    assert_selector "button.mb-3[type=button]"
  end

  def test_renders_a_text_field_with_primer_utility_color
    render_preview :submit_button_form

    assert_selector "input.color-fg-success[type=text]"
  end

  def test_the_input_is_marked_as_invalid
    render_preview :invalid_form

    assert_selector "input[type=text][name=last_name][invalid][aria-invalid]"
  end

  def test_autofocuses_the_first_invalid_input
    render_preview :invalid_form

    assert_selector "input[type=text][name=last_name][autofocus]"
  end

  def test_renders_horizontal_group
    render_preview :horizontal_form

    assert_selector ".FormControl-horizontalGroup .FormControl", count: 2
  end

  def test_renders_multi_input
    render_preview :multi_input_form

    assert_selector "label", text: "Region"

    assert_selector ".FormControl select[name=region]" do
      assert_selector "select option[value=WA]"
    end

    assert_selector ".FormControl select[name=region]", visible: false do
      assert_selector "select option[value=BC]", visible: false
    end
  end

  def test_radio_button_includes_nested_form
    render_preview :radio_button_with_nested_form

    assert_selector ".FormControl-radio-wrap + .ml-4 .FormControl input[name=first_name]"
  end

  def test_radio_button_group_form
    render_preview :radio_button_group_form

    assert_selector ".FormControl-radio-wrap + .FormControl-radio-wrap + .FormControl-radio-wrap"
  end

  def test_select_form
    render_preview :select_form

    assert_selector ".FormControl-select-wrap .FormControl-select.FormControl-medium" do |single_select|
      single_select.assert_selector "option[value='']"
      single_select.assert_selector "option[value=lopez_island]"
      single_select.assert_selector "option[value=bellevue]"
      single_select.assert_selector "option[value=seattle]"
    end

    assert_selector ".FormControl-select-wrap[data-multiple] .FormControl-select" do |multi_select|
      multi_select.assert_selector("option[value=lima]")
      multi_select.assert_selector("option[value=tokyo]")
      multi_select.assert_selector("option[value=reykjavik]")
      multi_select.assert_selector("option[value=chiang_mai]")
      multi_select.assert_selector("option[value=queenstown]")
    end
  end

  def test_composed_form
    render_preview :composed_form

    assert_selector ".FormControl-input[name='[first_name][first_name]']"
    assert_selector ".FormControl-input[name='[last_name][last_name]']"
  end

  def test_check_box_includes_nested_form
    render_preview :check_box_with_nested_form

    assert_selector ".FormControl-checkbox-wrap + .ml-4 .FormControl input[name=custom_cities]"
  end

  def test_renders_separator
    render_preview :multi_text_field_form

    assert_selector ".border-top.color-border-muted"
  end

  def test_renders_check_box_group
    render_preview :check_box_group_form

    %w[long_a long_i].each do |sound|
      assert_selector "fieldset input[type=hidden][value=0][name=#{sound}]", visible: false
      assert_selector "fieldset input[type=checkbox][value=1][name=#{sound}]" do
        assert_selector "label[for=#{sound}]"
      end
    end

    assert_selector "fieldset input[type=hidden][value=not_long_o][name=long_o]", visible: false
    assert_selector "fieldset input[type=checkbox][value=long_o][name=long_o]" do
      assert_selector "label[for=long_o]"
    end
  end

  def test_renders_array_check_box_group
    render_preview :array_check_box_group_form

    # check for rails' auto-inserted unchecked value field, which should not be present
    # in this case since no unchecked value is provided (we want an unchecked item to
    # simply not be present in the resulting array)
    refute_selector "input[type=hidden][value=0]", visible: false

    %w[lopez bellevue seattle].each do |place|
      assert_selector "fieldset input[type=checkbox][value=#{place}][name='places[]']" do
        assert_selector "label[for='places_#{place}']"
      end
    end

    assert_selector ".FormControl-caption span", text: "Vacation getaway"
  end

  def test_renders_hidden_input
    render_preview :multi_text_field_form

    assert_selector "input[type=hidden][name=csrf_token][value=abc123]", visible: false
  end

  def test_only_accepts_correct_form_builder
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        form_with(url: "/foo") do |f|
          render(SingleTextFieldForm.new(f))
        end
      end
    end

    assert_includes error.message, "please pass an instance of Primer::Forms::Builder"
  end

  def test_renders_field_name_with_question_mark_caption_template
    render_preview :name_with_question_mark_form

    assert_selector "input[name=enabled]"
    assert_selector ".my-test-caption"
  end

  def test_text_field_custom_element_is_form_control
    render_preview :single_text_field_form

    assert_selector "primer-text-field.FormControl"
  end

  def test_siblings_are_form_controls_when_including_a_multi_input
    render_preview :multi_input_form

    assert_selector ".FormControl-radio-group-wrap + .FormControl"
  end

  def test_toggle_switch_button_labelled_by_label
    render_preview(:example_toggle_switch_form)

    label_id = page.find_css(".FormControl-label")[0].attributes["id"].value
    assert_selector("toggle-switch button[aria-labelledby='#{label_id}']")
  end

  def test_toggle_switch_button_described_by_caption_and_validation_message
    render_preview(:example_toggle_switch_form)

    caption_id = page.find_css(".FormControl-caption")[0].attributes["id"].value
    validation_id = page.find_css(".FormControl-inlineValidation")[0].attributes["id"].value

    ids = page.find_css("toggle-switch button")[0].attributes["aria-describedby"].value.split

    assert_includes ids, caption_id
    assert_includes ids, validation_id
  end
end
