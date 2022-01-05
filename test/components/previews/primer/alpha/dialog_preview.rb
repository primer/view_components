# frozen_string_literal: true

module Primer
  module Alpha
    class DialogPreview < ViewComponent::Preview
      def default
        render(Primer::Alpha::Dialog.new)
      end
    end
  end
end
