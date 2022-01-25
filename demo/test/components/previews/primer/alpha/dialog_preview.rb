# frozen_string_literal: true

module Primer
  module Alpha
    class DialogPreview < ViewComponent::Preview
      def default
        render(Primer::Alpha::Dialog.new(title: "Preview Dialog", dialog_id: "my-custom-id")) do |c|
          c.show_button do 
            "Show dialog"
          end
          c.body do
            "Your custom content here"
          end
        end
      end
    end
  end
end
