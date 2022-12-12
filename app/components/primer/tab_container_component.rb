# frozen_string_literal: true

module Primer
  # Use `TabContainer` to create tabbed content with keyboard support. This component does not add any styles.
  # It only provides the tab functionality. If you want styled Tabs you can look at <%= link_to_component(Primer::Alpha::TabNav) %>.
  #
  # This component requires javascript.
  class TabContainerComponent < Primer::Component
    warn_on_deprecated_slot_setter

    # @example Default
    #   <%= render(Primer::TabContainerComponent.new)  do %>
    #     <div role="tablist">
    #       <button type="button" role="tab" aria-selected="true">Tab one</button>
    #       <button type="button" role="tab" tabindex="-1">Tab two</button>
    #       <button type="button" role="tab" tabindex="-1">Tab three</button>
    #     </div>
    #     <div role="tabpanel">
    #       Panel 1
    #     </div>
    #     <div role="tabpanel" hidden>
    #       Panel 2
    #     </div>
    #     <div role="tabpanel" hidden>
    #       Panel 3
    #     </div>
    #   <% end %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)
      @system_arguments[:tag] = "tab-container"
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end

    def render?
      content.present?
    end
  end
end
