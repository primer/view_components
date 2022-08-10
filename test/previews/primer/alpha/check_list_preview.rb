# frozen_string_literal: true

module Primer
  module Alpha
    class CheckListPreview < ViewComponent::Preview
      def playing_around
        render(Primer::Alpha::CheckList.new) do |c|
          c.item(label: "General") do |item|
            item.with_leading_visual_icon(icon: :gear)
          end

          c.section(aria: { label: "Access" }) do |section|
            section.heading { "Access" }

            section.item(label: "Collaborators and teams") do |item|
              item.with_leading_visual_icon(icon: :people)
            end

            section.item(label: "Moderation options") do |item|
              item.with_leading_visual_icon(icon: :"comment-discussion")
            end
          end
        end
      end
    end
  end
end
