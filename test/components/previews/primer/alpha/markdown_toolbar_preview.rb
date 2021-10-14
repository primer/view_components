module Primer
  module Alpha
    class MarkdownToolbarPreview < ViewComponent::Preview
      def default
        render(Primer::Alpha::MarkdownToolbar.new)
      end
    end
  end
end
