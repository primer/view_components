# frozen_string_literal: true

require "primer/alpha/navigation_list"

class Primer::Alpha::NavigationListStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:navigation_list) do
    controls do
      aria(label: "Navigation List")
      select(:selected_item_id, [:link_1, :link_2, :link_3], :link_1)
    end

    content do |c|
      c.section(aria: { label: "Section" }) do |section|
        section.heading { "Section 1" }

        section.item(selected_by_ids: :link_1) do
          "Link 1"
        end

        section.item(selected_by_ids: :link_2) do |item|
          item.leading_visual_icon(icon: :plug)
          "Link with leading visual icon"
        end

        section.item(selected_by_ids: :link_3) do |item|
          item.trailing_visual_icon(icon: :plug)
          "Link with trailing visual icon"
        end
      end

      c.section(aria: { label: "Section" }) do |section|
        section.heading { "Section 2" }

        section.item(selected_by_ids: :link_a) do
          "Link a"
        end

        section.item(selected_by_ids: :link_b) do
          "Link b"
        end
      end
    end
  end
end
