# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class SideNav < Primer::Component
      renders_many :items, lambda { |href:, selected: false, **system_arguments|
        system_arguments["aria-current"] = :page if selected
        system_arguments[:classes] = class_names(
          "SideNav-item",
          system_arguments[:classes]
        )

        Primer::BaseComponent.new(tag: :a, href: href, **system_arguments)
      }

      # @example Example goes here
      #
      #   <%= render(Primer::Alpha::SideNav.new) { "Example" } %>
      #
      # @param bordered [Boolean] Whether or not to render a bordered version of the component.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(bordered: true, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :nav
        @system_arguments[:border] = true if bordered
        @system_arguments[:border_radius] = 2

        @system_arguments[:classes] = class_names(
          "SideNav",
          system_arguments[:classes]
        )
      end
    end
  end
end
