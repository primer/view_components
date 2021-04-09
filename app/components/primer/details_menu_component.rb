# frozen_string_literal: true

module Primer
  # Use DetailsMenuComponent for a menu that is opened with a <details> button and includes enhanced javascript behavior.
  # This is not a stand alone component and should always be used with a [DetailsComponent](http://localhost:5400/components/details).
  #
  # For guidance on usage, [see this](https://github.com/github/details-menu-element).
  # @example Default
  #   <%= render(Primer::DetailsComponent.new) do |c| %>
  #     <% c.summary do %>
  #       <span data-menu-button>None</span>
  #     <% end %>
  #     <% c.body do %>
  #       <%= render(Primer::DetailsMenuComponent.new) do %>
  #         <button type="button" role="menuitem" data-menu-button-contents>Item 1</button>
  #         <button type="button" role="menuitem" data-menu-button-contents>Item 2</button>
  #         <button type="button" role="menuitem" data-menu-button-contents>Item 3</button>
  #       <% end %>
  #     <% end %>
  #   <% end %>
  #
  # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
  class DetailsMenuComponent < Primer::Component
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = "details-menu"
      @system_arguments[:role] = "menu"
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
