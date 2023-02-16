# frozen_string_literal: true

module Primer
  module Alpha
    # @label ActionMenu
    class ActionMenuPreview < ViewComponent::Preview
      # @label Playground
      #
      def playground
        render(Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-0")) do |c|
          c.with_trigger { "Menu" }
          c.with_item(label: "Primer Design", single_select: true)
        end
      end
    end
  end
end
