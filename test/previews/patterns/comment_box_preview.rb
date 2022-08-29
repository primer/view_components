# frozen_string_literal: true

module Patterns
  # @label Comment box
  class CommentBoxPreview < ViewComponent::Preview
    def default
      render_with_template(locals: {})
    end
  end
end
