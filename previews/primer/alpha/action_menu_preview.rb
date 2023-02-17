# frozen_string_literal: true

module Primer
  module Alpha
    # @label ActionMenu
    class ActionMenuPreview < ViewComponent::Preview
      # @label Playground
      #
      def playground
        render(Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-0", select_variant: :single)) do |c|
          c.with_trigger { "Menu" }
          c.with_item(label: "Primer Design")
          c.with_item(label: "Primer Design")
          c.with_item(label: "Primer Design")
        end
      end

      # @label Multiple
      #
      def multiple
        render(Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-0", select_variant: :multiple)) do |c|
          c.with_trigger { "Menu" }
          c.with_item(label: "Primer Design")
          c.with_item(label: "Primer Design")
          c.with_item(label: "Primer Design")
        end
      end
    end
  end
end
