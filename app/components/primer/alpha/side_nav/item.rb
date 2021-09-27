# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class SideNav
      # Doc this at some point
      class Item < Primer::Component
        renders_one :leading_visual, lambda { |src: nil, alt: nil, icon: nil, **system_arguments|
          if icon
            Primer::OcticonComponent.new(icon: icon, **system_arguments)
          else
            Primer::Beta::Avatar.new(src: src, alt: alt, **system_arguments)
          end
        }

        def initialize(href:, selected: false, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = :a
          @system_arguments[:href] = href
          @system_arguments[:"aria-current"] = :page if selected

          @system_arguments[:classes] = class_names(
            "SideNav-item",
            system_arguments[:classes]
          )
        end
      end
    end
  end
end
