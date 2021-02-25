# frozen_string_literal: true

module Primer
  module Breadcrumb
    # This component is part of `Primer::BreadcrumbComponent` and should not be
    # used as a standalone component.
    class ItemComponent < Primer::Component
      def initialize(href: nil, selected: false, **system_arguments)
        @href = href
        @system_arguments = system_arguments

        @href = nil if selected
        @system_arguments[:tag] = :li
        @system_arguments[:"aria-current"] = "page" if selected
        @system_arguments[:classes] = "breadcrumb-item #{@system_arguments[:classes]}"
      end
    end
  end
end
