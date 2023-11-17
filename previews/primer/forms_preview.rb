# frozen_string_literal: true

module Primer
  # :nodoc:
  class FormsPreview < ViewComponent::Preview
    def single_text_field_form; end

    def multi_text_field_form; end

    def text_field_and_checkbox_form; end

    def horizontal_form; end

    def composed_form; end

    def submit_button_form; end

    def radio_button_group_form; end

    def check_box_group_form; end

    def array_check_box_group_form; end

    def select_form; end

    def action_menu_form(route_format: :html)
      render_with_template(locals: { route_format: route_format })
    end

    def radio_button_with_nested_form; end

    def check_box_with_nested_form; end

    def caption_template_form; end

    def after_content_form; end

    def invalid_form; end

    def multi_input_form; end

    def name_with_question_mark_form; end

    def immediate_validation_form; end

    def example_toggle_switch_form; end
  end
end
