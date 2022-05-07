# frozen_string_literal: true

module Beta
  # @label AutoComplete
  class AutoCompletePreview < ViewComponent::Preview
    # @label Default Options
    # @param label_text text
    # @param is_label_visible toggle
    # @param is_label_inline toggle
    # @param with_icon toggle
    # @param is_clearable toggle
    # @param visually_hide_label toggle
    def default(label_text: "Select a fruit", is_label_visible: true, is_label_inline: false, with_icon: false, is_clearable: false, visually_hide_label: false)
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: "input-id", list_id: "test-id", src: "/auto_complete", is_label_visible: is_label_visible, is_label_inline: is_label_inline, with_icon: with_icon, is_clearable: is_clearable, visually_hide_label: visually_hide_label))
    end

    # @label Playground
    # @param label_text text
    # @param is_label_visible toggle
    # @param is_label_inline toggle
    # @param with_icon toggle
    # @param is_clearable toggle
    # @param visually_hide_label toggle
    def playground(label_text: "Select a fruit", is_label_visible: true, is_label_inline: false, with_icon: false, is_clearable: false, visually_hide_label: false)
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: "input-id", list_id: "test-id", src: "/auto_complete", is_label_visible: is_label_visible, is_label_inline: is_label_inline, with_icon: with_icon, is_clearable: is_clearable, visually_hide_label: visually_hide_label)) do |c|
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
      render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id-1", list_id: "test-id-1", src: "/auto_complete", is_label_visible: false))
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
      render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id-4", list_id: "test-id-4", src: "/auto_complete", is_clearable: true))
    end

    # @!endgroup
  end
end
