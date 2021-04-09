module Primer
  class AutoCompletePreview < ViewComponent::Preview
    def default
      render(Primer::AutoComplete.new(id: "test-id", src: "/auto_complete", position: :relative)) do |c|
        c.input(type: :text, name: "input")
      end
    end

    def with_icon
      render(Primer::AutoComplete.new(id: "test-id", src: "/auto_complete", position: :relative)) do |c|
        c.icon(icon: :search)
        c.input(type: :text, name: "input")
      end
    end
  end
end
