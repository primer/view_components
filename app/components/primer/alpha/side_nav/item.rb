# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class SideNav
      # Doc this at some point
      class Item < Primer::Component
        LEADING_VISUAL_COMPONENTS = [Primer::Beta::Avatar, Primer::OcticonComponent].freeze

        # @param component [Primer::Beta::Avatar|Primer::OcticonComponent] Instance of one of those components.
        renders_one :leading_visual, lambda { |component|
          case component
          when *LEADING_VISUAL_COMPONENTS
            component
          else
            raise ArgumentError, "Leading visual only accepts either Octicon or Avatar"
          end
        }

        # @param component_name [String] One of Octicon, Label or Counter
        # @param kwargs [Hash] The arguments of <%= link_to_component(Primer::OcticonComponent) %>, <%= link_to_component(Primer::LabelComponent) %> or  <%= link_to_component(Primer::CounterComponent) %>.
        renders_one :trailing_visual, lambda { |component_name, **kwargs|
          case component_name
          when "Octicon"
            Primer::OcticonComponent.new(**kwargs)
          when "Label"
            Primer::LabelComponent.new(**kwargs)
          else
            Primer::CounterComponent.new(**kwargs)
          end
        }

        def initialize(href:, selected: false, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = :a
          @system_arguments[:href] = href
          @system_arguments[:"aria-current"] = :page if selected
          @system_arguments[:display] = :flex
          @system_arguments[:align_items] = :center

          @system_arguments[:classes] = class_names(
            "SideNav-item",
            system_arguments[:classes]
          )
        end

        def before_render
          return if trailing_visual.blank?

          @system_arguments[:justify_content] = :space_between
        end
      end
    end
  end
end
