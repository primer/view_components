# frozen_string_literal: true

module Primer
  # :nodoc:
  class FormsPreview < ViewComponent::Preview
    # @snapshot
    def single_text_field_form; end

    # @snapshot
    def multi_text_field_form; end

    # @snapshot
    def text_field_and_checkbox_form; end

    # @snapshot
    def horizontal_form; end

    # @snapshot
    def composed_form; end

    # @snapshot
    def submit_button_form; end

    # @snapshot
    def radio_button_group_form; end

    # @snapshot
    def check_box_group_form; end

    # @snapshot
    def array_check_box_group_form; end

    # @snapshot
    def select_form; end

    # @snapshot
    def action_menu_form(route_format: :html)
      render_with_template(locals: { route_format: route_format })
    end

    # @snapshot
    def radio_button_with_nested_form; end

    # @snapshot
    def check_box_with_nested_form; end

    # @snapshot
    def caption_template_form; end

    # @snapshot
    def after_content_form; end

    # @snapshot
    def invalid_form; end

    # @snapshot
    def multi_input_form; end

    # @snapshot
    def name_with_question_mark_form; end

    # @snapshot
    def immediate_validation_form; end

    # @snapshot
    def example_toggle_switch_form; end

    # @snapshot
    def auto_complete_form; end
  end
end
