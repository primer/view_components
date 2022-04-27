# frozen_string_literal: true

# no doc
class AutoCompletePreview < ViewComponent::Preview
  def default
    render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete"))
  end

  def with_non_visible_label
    render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", is_label_visible: false))
  end

  def with_icon
    render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", with_icon: true))
  end

  def with_clear_button
    render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", is_clearable: true))
  end
end
