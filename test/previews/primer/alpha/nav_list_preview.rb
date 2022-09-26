# frozen_string_literal: true

module Primer
  module Alpha
    # @label NavList
    class NavListPreview < ViewComponent::Preview
      def default
        render(Primer::Alpha::NavList.new(selected_item_id: :code_review_limits, aria: { label: "Repository settings" })) do |c|
          c.with_heading(title: "Repository settings")

          c.with_item(label: "General", href: "/general") do |item|
            item.with_leading_visual_icon(icon: :gear)
          end

          c.with_group(aria: { label: "Access" }) do |list|
            list.with_heading(title: "Access")

            list.with_item(label: "Collaborators and teams", href: "/collaborators", selected_by_ids: :collaborators) do |item|
              item.with_leading_visual_icon(icon: :people)
            end

            list.with_item(label: "Moderation options", href: "/moderation") do |item|
              item.with_leading_visual_icon(icon: :"comment-discussion")

              item.with_item(label: "Interaction limits", href: "/interaction-limits", selected_by_ids: :interaction_limits)
              item.with_item(label: "Code review limits", href: "/review-limits", selected_by_ids: :code_review_limits)
              item.with_item(label: "Reported content", href: "/reported-content", selected_by_ids: :reported_content)
            end
          end
        end
      end

      # @label Show more item
      def show_more_item
        render(Primer::Alpha::NavList.new(aria: { label: "List of foods" })) do |list|
          list.with_heading(title: "My favorite foods")
          list.with_item(label: "Popplers", href: "/foods/popplers")
          list.with_item(label: "Slurm", href: "/foods/slurm")
          list.with_show_more_item(label: "Show more", src: "/nav_list_items", pages: 2)
        end
      end

      # @label Trailing action
      def trailing_action
        render(Primer::Alpha::NavList.new(aria: { label: "List of items to buy" })) do |list|
          list.with_heading(title: "Shopping list")
          list.with_item(label: "Bread", href: "/list/1") do |item|
            item.with_trailing_action(show_on_hover: true, icon: :plus, aria: { label: "Button tooltip" })
          end
          list.with_item(label: "Cheese", href: "/list/2") do |item|
            item.with_trailing_action(icon: :plus, aria: { label: "Button tooltip" })
          end
        end
      end
    end
  end
end
