# frozen_string_literal: true

module Primer
  # @label Box
  class BoxPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param content [String] text
    def playground(content: "Playground")
      render(Primer::Box.new) { content }
    end

    # @label Default
    def default(content: "Default")
      render(Primer::Box.new) { content }
    end

    # @label Border
    def border(content: "Box with border")
      render(Primer::Box.new(border: true, p: 3)) { content }
    end

    # @label Border Bottom
    def border_bottom(content: "Box with bottom border")
      render(Primer::Box.new(border: :bottom, p: 3)) { content }
    end
  end
end
