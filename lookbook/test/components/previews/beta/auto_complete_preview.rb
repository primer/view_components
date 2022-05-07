# frozen_string_literal: true

module Beta
  # @label AutoComplete
  class AutoCompletePreview < ViewComponent::Preview
    # @label Default Options
    # @param label_text text
    # @param is_label_inline toggle
    # @param with_icon toggle
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    def default(label_text: "Select a fruit", is_label_inline: false, with_icon: false, show_clear_button: false, visually_hide_label: false)
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: "input-id", list_id: "test-id", src: "/auto_complete", is_label_inline: is_label_inline, with_icon: with_icon, show_clear_button: show_clear_button, visually_hide_label: visually_hide_label))
    end

    # @label Playground
    # @param label_text text
    # @param is_label_inline toggle
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param label_position select [block, inline]
    # @param full_width toggle
    def playground(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, label_position: :block, full_width: false)
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: "input-id", list_id: "test-id", src: "/auto_complete", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, label_position: label_position, full_width: full_width)) do |c|
        c.leading_visual_icon(icon: :search)
        c.results do
          render(Primer::Beta::AutoComplete::Item.new(selected: true, value: "apple")) do |_c|
            Apple
          end
          render(Primer::Beta::AutoComplete::Item.new(value: "orange")) do |_c|
            Orange
          end
        end
      end
    end

    # @!group More examples

    # @label AutoComplete with non-visible label
    def with_non_visible_label
      render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id-1", list_id: "test-id-1", src: "/auto_complete"))
    end

    # @label AutoComplete with inline label
    def with_inline_label
      render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id-2", list_id: "test-id-2", src: "/auto_complete", is_label_inline: true))
    end

    # @label AutoComplete with search icon
    def with_icon
      render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id-3", list_id: "test-id-3", src: "/auto_complete", with_icon: true))
    end

    # @label AutoComplete with clear button
    def with_clear_button
      render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id-4", list_id: "test-id-4", src: "/auto_complete", show_clear_button: true))
    end

    # @!endgroup
  end
end
