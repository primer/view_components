# frozen_string_literal: true

require "test_helper"
require_relative "form_test_component"

class Primer::Forms::FormsTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class DeepThought
    if Rails::VERSION::STRING < "7.0"
      include ActiveModel::Model
    else
      include ActiveModel::API
    end

    include ActiveModel::Validations

    attr_reader :ultimate_answer

    def initialize(ultimate_answer)
      @ultimate_answer = ultimate_answer
    end

    validates :ultimate_answer, numericality: { greater_than: 41, less_than: 43 }
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

  def test_includes_the_given_note
    render_preview :single_text_field_form

    assert_selector ".FormControl-caption", text: "The answer to life, the universe, and everything"
  end

  def test_the_input_is_described_by_the_caption
    render_preview :single_text_field_form

    caption_id = page.find_all(".FormControl-caption").first["id"]
    assert_selector "input[aria-describedby='#{caption_id}']"
  end

  def test_includes_activemodel_validation_messages
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    assert_selector ".FormControl" do
      assert_selector ".FormControl-inlineValidation", text: "Ultimate answer must be greater than 41" do
        assert_selector ".octicon-alert-fill"
      end
    end
  end

  def test_names_inputs_correctly_when_rendered_against_an_activemodel
    model = DeepThought.new(42)

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    text_field = page.find_all("input[type=text]").first
    assert_equal text_field["name"], "primer_forms_forms_test_deep_thought[ultimate_answer]"
  end

  def test_the_input_is_described_by_the_validation_message
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    validation_id = page.find_all(".FormControl-inlineValidation").first["id"]
    described_by = page.find_all("input[type='text']").first["aria-describedby"]
    assert described_by.split.include?(validation_id)
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
      caption_id = input["aria-describedby"]
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

  def test_renders_a_submit_button
    render_preview :submit_button_form

    assert_selector "button[type=submit]"
  end

  def test_renders_a_submit_button_without_data_disable_with
    render_preview :submit_button_form

    button = page.find_all("button[type=submit]").first
    assert_nil button["data-disable-with"]
  end

  def test_renders_a_submit_button_with_primer_utility_margin
    render_preview :submit_button_form

    assert_selector "button.mr-3[type=submit]"
  end

  def test_renders_a_text_field_with_primer_utility_color
    render_preview :submit_button_form

    assert_selector "input.color-fg-success[type=text]"
  end

  def test_autofocuses_the_first_invalid_input
    render_preview :invalid_form

    assert_selector "input[type=text][name=last_name][autofocus]"
  end

  def test_renders_horizontal_group
    render_preview :horizontal_form

    assert_selector ".d-flex.flex-column .d-flex .FormControl", count: 2
  end

  def test_renders_multi_input
    render_preview :multi_input_form

    assert_selector ".FormControl select[name=region]" do
      assert_selector "label", text: "State"
    end

    assert_selector ".FormControl select[name=region]", visible: false do
      assert_selector "label", text: "Province", visible: false
    end
  end

  def test_radio_button_includes_nested_form
    render_preview :radio_button_with_nested_form

    assert_selector ".FormControl-radio-wrap + .ml-4 .FormControl input[name=first_name]"
  end

  def test_renders_separator
    render_preview :multi_text_field_form

    assert_selector ".border-top.color-border-muted"
  end

  def test_renders_check_box_group
    render_preview :check_box_group_form

    %w[long_a long_i long_o].each do |sound|
      assert_selector "fieldset input[type=hidden][value=0][name=#{sound}]", visible: false
      assert_selector "fieldset input[type=checkbox][value=1][name=#{sound}]" do
        assert_selector "label[for=#{sound}]"
      end
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
end
