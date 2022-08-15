# frozen_string_literal: true

module Primer
  module Alpha
    # @label NavList
    class NavListPreview < ViewComponent::Preview
      def playing_around
        render(Primer::Alpha::NavList.new(selected_item_id: :code_review_limits, aria: { label: "Repository settings" })) do |c|
          c.with_item(label: "General", href: "/general") do |item|
            item.with_leading_visual_icon(icon: :gear)
          end

          c.with_group(aria: { label: "Access" }) do |group|
            group.with_heading { "Access" }

            group.with_item(label: "Collaborators and teams", href: "/collaborators", selected_by_ids: :collaborators) do |item|
              item.with_leading_visual_icon(icon: :people)
            end

            group.with_item(label: "Moderation options", href: "/moderation") do |item|
              item.with_leading_visual_icon(icon: :"comment-discussion")

              item.with_subitem(label: "Interaction limits", href: "/interaction-limits", selected_by_ids: :interaction_limits)
              item.with_subitem(label: "Code review limits", href: "/review-limits", selected_by_ids: :code_review_limits)
              item.with_subitem(label: "Reported content", href: "/reported-content", selected_by_ids: :reported_content)
            end
          end
        end
      end
    end
  end
end
