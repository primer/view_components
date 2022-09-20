# frozen_string_literal: true

module Primer
  module Alpha
    # @label NavList
    class NavListPreview < ViewComponent::Preview
      def playground
        render(Primer::Alpha::NavList.new(selected_item_id: :code_review_limits, aria: { label: "Repository settings" })) do |c|
          c.with_item(label: "General", href: "/general") do |item|
            item.with_leading_visual_icon(icon: :gear)
          end

          c.with_list(aria: { label: "Access" }) do |list|
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
    end
  end
end
