# frozen_string_literal: true

module Primer
  # :nodoc:
  class FormsPreview < ViewComponent::Preview
    # @snapshot interactive
    def single_text_field_form; end

    # @snapshot interactive
    def multi_text_field_form; end

    # @snapshot interactive
    def text_field_and_checkbox_form; end

    # @snapshot interactive
    def horizontal_form; end

    # @snapshot interactive
    def composed_form; end

    # @snapshot interactive
    def submit_button_form; end

    # @snapshot interactive
    def radio_button_group_form; end

    # @snapshot interactive
    def check_box_group_form; end

    # @snapshot interactive
    def array_check_box_group_form; end

    # @snapshot interactive
    def select_form; end

    # @snapshot interactive
    def action_menu_form(route_format: :html)
      render_with_template(locals: { route_format: route_format })
    end

    # @snapshot interactive
    def radio_button_with_nested_form; end

    # @snapshot interactive
    def check_box_with_nested_form; end

    # @snapshot interactive
    def caption_template_form; end

    # @snapshot interactive
    def after_content_form; end

    # @snapshot interactive
    def invalid_form; end

    # @snapshot interactive
    def multi_input_form; end

    # @snapshot interactive
    def name_with_question_mark_form; end

    # @snapshot interactive
    def immediate_validation_form; end

    # @snapshot interactive
    def example_toggle_switch_form; end

    # @snapshot interactive
    def auto_complete_form; end
  end
end
