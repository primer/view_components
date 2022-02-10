module Primer
  class TooltipPreview < ViewComponent::Preview
    def default
      render(Primer::ButtonComponent.new(id: "dislike-button", "aria-label": "Dislike")) { "👍" }
      render(Primer::Alpha::Tooltip.new(for_id: "dislike-button", type: :description, text: "This means you dislike this comment"))
    end

    def label
      render(Primer::ButtonComponent.new(id: "like-button")) { "👍" }
      render(Primer::Alpha::Tooltip.new(for_id: "like-button", type: :label, text: "Like"))
    end
  end
end
