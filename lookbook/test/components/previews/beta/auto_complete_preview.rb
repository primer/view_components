# frozen_string_literal: true

module Beta
  # @label AutoComplete
  class AutoCompletePreview < ViewComponent::Preview
    # @label Playground
    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def playground(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: "/auto_complete", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid, input_name: input_name)) do |c|
        c.leading_visual_icon(icon: :search)
      end
    end

    # @label With submit button
    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def with_submit_button(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: true, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
      render_with_template(locals: {
                             label_text: label_text,
                             show_clear_button: show_clear_button,
                             visually_hide_label: visually_hide_label,
                             placeholder: placeholder,
                             size: size,
                             full_width: full_width,
                             disabled: disabled,
                             invalid: invalid,
                             input_id: input_id,
                             list_id: list_id,
                             input_name: input_name
                           })
    end

    # @label Leading visual
    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def leading_visual(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: "/auto_complete", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid, input_name: input_name)) do |c|
        c.leading_visual_icon(icon: :search)
      end
    end

    # @label Trailing action
    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def trailing_action(label_text: "Select a fruit", show_clear_button: true, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: "/auto_complete", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid, input_name: input_name)) do |c|
      end
    end

    # @label Full width
    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def full_width(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: true, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: "/auto_complete", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid, input_name: input_name)) do |c|
        c.leading_visual_icon(icon: :search)
      end
    end

    # @label Visually hide label
    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def visually_hide_label(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: true, placeholder: "Placeholder text", size: :medium, full_width: false, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: "/auto_complete", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid, input_name: input_name)) do |c|
        c.leading_visual_icon(icon: :search)
      end
    end

    # @!group Sizes

    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def small(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :small, full_width: false, disabled: false, invalid: false, input_id: "input-id-1", list_id: "list-id-1", input_name: "input-id-1")
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: "/auto_complete", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid, input_name: input_name)) do |c|
        c.leading_visual_icon(icon: :search)
      end
    end

    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def medium(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, disabled: false, invalid: false, input_id: "input-id-2", list_id: "list-id-2", input_name: "input-id-2")
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: "/auto_complete", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid, input_name: input_name)) do |c|
        c.leading_visual_icon(icon: :search)
      end
    end

    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def large(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :large, full_width: false, disabled: false, invalid: false, input_id: "input-id-3", list_id: "list-id-3", input_name: "input-id-3")
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: "/auto_complete", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid, input_name: input_name)) do |c|
        c.leading_visual_icon(icon: :search)
      end
    end

    # @!endgroup

    # @label Leading visual in results
    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def leading_visual_in_results(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: "/auto_complete?visual=leading", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid, input_name: input_name)) do |c|
      end
    end

    # @label Trailing visual in results
    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    # @param input_id text
    # @param list_id text
    # @param input_name text
    def trailing_visual_in_results(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: "/auto_complete?visual=trailing", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid, input_name: input_name))
    end
  end
end
