# frozen_string_literal: true

module Primer
  # This component is used by [DetailsComponent][1] and [Dropdown::MenuComponent][1],
  # and should not be used as a standalone component.
  #
  # This can be used to provide `<details>` with a menu that has enhanced keyboard navigations as well as
  # configurable [javascript][2] behaviors. For further guidance on usage, please see [details-menu-element][1].
  #
  # [1]: https://primer.style/view-components/components/details
  # [2]: https://github.com/github/details-menu-element
  #
  class DetailsMenuComponent < Primer::Component
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
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
