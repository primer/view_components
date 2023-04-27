# frozen_string_literal: true

module Primer
  module Alpha
    # @label NavList
    class NavListPreview < ViewComponent::Preview
      # @label Playground
      def playground
        render(Primer::Alpha::NavList.new(aria: { label: "Repository settings" }, selected_item_id: :code_review_limits)) do |list|
          list.with_heading(title: "Repository settings")

          list.with_item(label: "General", href: "/general") do |item|
            item.with_leading_visual_icon(icon: :gear)
          end

          list.with_group do |group|
            group.with_heading(title: "Access")

            group.with_item(label: "Collaborators and teams", href: "/collaborators", selected_by_ids: :collaborators) do |item|
              item.with_leading_visual_icon(icon: :people)
            end

            group.with_item(label: "Moderation options") do |item|
              item.with_leading_visual_icon(icon: :"comment-discussion")

              item.with_item(label: "Interaction limits", href: "/interaction-limits", selected_by_ids: :interaction_limits)
              item.with_item(label: "Code review limits", href: "/review-limits", selected_by_ids: :code_review_limits)
              item.with_item(label: "Reported content", href: "/reported-content", selected_by_ids: :reported_content)
            end
          end
        end
      end

      # @label Default
      def default
        render(Primer::Alpha::NavList.new(aria: { label: "Repository settings" }, selected_item_id: :code_review_limits)) do |list|
          list.with_heading(title: "Repository settings")

          list.with_item(label: "General", href: "/general") do |item|
            item.with_leading_visual_icon(icon: :gear)
          end

          list.with_group do |group|
            group.with_heading(title: "Access")

            group.with_item(label: "Collaborators and teams", href: "/collaborators", selected_by_ids: :collaborators) do |item|
              item.with_leading_visual_icon(icon: :people)
            end

            group.with_item(label: "Moderation options") do |item|
              item.with_leading_visual_icon(icon: :"comment-discussion")

              item.with_item(label: "Interaction limits", href: "/interaction-limits", selected_by_ids: :interaction_limits)
              item.with_item(label: "Code review limits", href: "/review-limits", selected_by_ids: :code_review_limits)
              item.with_item(label: "Reported content", href: "/reported-content", selected_by_ids: :reported_content)
            end
          end
        end
      end

      # @label Top-level items
      #
      def top_level_items
        render(Primer::Alpha::NavList.new(aria: { label: "Account settings" })) do |list|
          list.with_heading(title: "Account settings navigation")

          list.with_item(label: "General", href: "/general") do |item|
            item.with_leading_visual_icon(icon: :gear)
          end

          list.with_item(label: "Billing", href: "/billing") do |item|
            item.with_leading_visual_icon(icon: :"credit-card")
          end

          list.with_item(label: "Change password", href: "/change_password") do |item|
            item.with_leading_visual_icon(icon: :key)
          end
        end
      end

      # @label Show more item
      def show_more_item
        render(Primer::Alpha::NavList.new(aria: { label: "My favorite foods" })) do |list|
          list.with_group do |group|
            group.with_heading(title: "My favorite foods")
            group.with_item(label: "Popplers", href: "/foods/popplers")
            group.with_item(label: "Slurm", href: "/foods/slurm")
            group.with_show_more_item(label: "Show more foods", src: UrlHelpers.nav_list_items_path, pages: 2)
          end
        end
      end

      # @label Trailing action
      def trailing_action; end
    end
  end
end
