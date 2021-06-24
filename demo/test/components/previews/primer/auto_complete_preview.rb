module Primer
  class AutoCompletePreview < ViewComponent::Preview
    def default
      render(Primer::AutoComplete.new(input_id: "input-id", list_id: "test-id", src: "/auto_complete", position: :relative)) do |c|
        c.input(type: :text, name: "input", "aria-label": "Select a fruit")
      end
    end

    def with_visible_label
      render(Primer::AutoComplete.new(input_id: "input-id", list_id: "test-id", src: "/auto_complete", position: :relative)) do |c|
        c.label.with_content("This is a label")
        c.input(type: :text, name: "input")
      end
    end

    def with_icon
      render(Primer::AutoComplete.new(input_id: "input-id", list_id: "test-id", src: "/auto_complete", position: :relative)) do |c|
        c.icon(icon: :search)
        c.input(type: :text, name: "input", "aria-label": "Select a fruit")
      end
    end
  end
end
