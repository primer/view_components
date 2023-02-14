# frozen_string_literal: true

module Primer
  module Alpha
    # @label NavList
    class NavListPreview < ViewComponent::Preview
      # @label Playground
      def playground
        render(Primer::Alpha::NavList.new(selected_item_id: :code_review_limits)) do |list|
          list.with_section do |section|
            section.with_heading(title: "Repository settings")

            section.with_item(label: "General", href: "/general") do |item|
              item.with_leading_visual_icon(icon: :gear)
            end
          end

          list.with_section do |section|
            section.with_heading(title: "Access")

            section.with_item(label: "Collaborators and teams", href: "/collaborators", selected_by_ids: :collaborators) do |item|
              item.with_leading_visual_icon(icon: :people)
            end

            section.with_item(label: "Moderation options") do |item|
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
        render(Primer::Alpha::NavList.new(selected_item_id: :code_review_limits)) do |list|
          list.with_section do |section|
            section.with_heading(title: "Repository settings")

            section.with_item(label: "General", href: "/general") do |item|
              item.with_leading_visual_icon(icon: :gear)
            end
          end

          list.with_section do |section|
            section.with_heading(title: "Access")

            section.with_item(label: "Collaborators and teams", href: "/collaborators", selected_by_ids: :collaborators) do |item|
              item.with_leading_visual_icon(icon: :people)
            end

            section.with_item(label: "Moderation options", href: "/moderation") do |item|
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
        render(Primer::Alpha::NavList.new) do |list|
          list.with_section do |section|
            section.with_heading(title: "My favorite foods")
            section.with_item(label: "Popplers", href: "/foods/popplers")
            section.with_item(label: "Slurm", href: "/foods/slurm")
            section.with_show_more_item(label: "Show more", src: "/nav_list_items", pages: 2)
          end
        end
      end

      # @label Trailing action
      def trailing_action
        render(Primer::Alpha::NavList.new) do |list|
          list.with_section do |section|
            section.with_heading(title: "Shopping list")
            section.with_item(label: "Bread", href: "/list/1") do |item|
              item.with_trailing_action(show_on_hover: true, icon: :plus, aria: { label: "Button tooltip" })
            end
            section.with_item(label: "Cheese", href: "/list/2") do |item|
              item.with_trailing_action(icon: :plus, aria: { label: "Button tooltip" })
            end
          end
        end
      end
    end
  end
end
