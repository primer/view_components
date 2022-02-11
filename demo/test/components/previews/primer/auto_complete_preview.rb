module Primer
  class AutoCompletePreview < ViewComponent::Preview
    def default
      render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", position: :relative))
    end

    def with_non_visible_label
      render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", is_label_visible: false, position: :relative))
    end

    def with_icon
      render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", position: :relative)) do |c|
        c.icon(icon: :search)
      end
    end
  end
end
