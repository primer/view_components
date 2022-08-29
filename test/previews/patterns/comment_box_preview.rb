# frozen_string_literal: true

module Patterns
  # @label Comment box
  class CommentBoxPreview < ViewComponent::Preview
    # @param container [Symbol] select [[None, nil], [Small, sm], [Medium, md], [Large, lg], [XLarge, xl]]
    def default(container: nil)
      render_with_template(locals: { container: container })
    end
  end
end
