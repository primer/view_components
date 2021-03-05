module Primer
  class AutoCompleteComponentPreview < ViewComponent::Preview
    def default
      render(Primer::AutoCompleteComponent.new(id: "test-id", src: "/auto_complete", position: :relative)) do |c|
        c.input(type: :text, name: "input", classes: "form-control")
      end
    end

    def with_icon
      render(Primer::AutoCompleteComponent.new(id: "test-id", src: "/auto_complete", position: :relative)) do |c|
        c.icon(icon: :search)
        c.input(type: :text, name: "input", classes: "form-control")
      end
    end
  end
end
