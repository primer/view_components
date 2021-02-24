# frozen_string_literal: true

module Primer
  # Use TabNavContainer to create a tabbed navigation without changing pages.
  class TabNavContainerComponent < Primer::Component
    include ViewComponent::SlotableV2

    # The TabNav component.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::TabNavComponent) %>.
    renders_one :nav, ->(**system_arguments) { Primer::TabNavComponent.new(with_panel: true, **system_arguments) }

    # @example auto|Default
    #   <%= render(Primer::TabNavContainerComponent.new) do |c| %>
    #     <% c.nav do |nav| %>
    #       <% nav.tab(selected: true, title: "Tab 1") { "Panel 1" } %>
    #       <% nav.tab(title: "Tab 2") { "Panel 2" } %>
    #       <% nav.tab(title: "Tab 3") { "Panel 3" } %>
    #     <% end %>
    #   <% end %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
    end

    def render?
      nav.present?
    end
  end
end
