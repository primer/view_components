# frozen_string_literal: true

module Primer
  # Use menus to create vertical lists of navigational links.
  class MenuComponent < Primer::Component
    include ViewComponent::SlotableV2

    renders_one :heading, lambda { |**system_arguments|
      system_arguments[:tag] = :span
      system_arguments[:classes] = class_names(
        "menu-heading",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    renders_many :items, lambda { |href:, selected: false, **system_arguments|
      system_arguments[:tag] = :a
      system_arguments[:"aria-current"] = :page if selected
      system_arguments[:classes] = class_names(
        "menu-item",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }
    # @example 215|Default
    #   <%= render(Primer::MenuComponent.new) do |c| %>
    #     <% c.heading do %>
    #       Heading
    #     <% end %>
    #     <% c.item(selected: true, href: "#url") do %>
    #       Item 1
    #     <% end %>
    #     <% c.item(selected: true, href: "#url") do %>
    #       <%= render(Primer::OcticonComponent.new(icon: "check")) %>
    #       With Icon
    #     <% end %>
    #     <% c.item(selected: true, href: "#url") do %>
    #       <%= render(Primer::OcticonComponent.new(icon: "check")) %>
    #       With Icon and Counter
    #       <%= render(Primer::CounterComponent.new(count: 25)) %>
    #     <% end %>
    #   <% end %>
    #
    # @param href [String] URL to be used for the Link
    # @param muted [Boolean] Uses light gray for Link color, and blue on hover
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :nav
      @system_arguments[:classes] = class_names(
        "menu"
        @system_arguments[:classes],
      )
    end
  end
end
