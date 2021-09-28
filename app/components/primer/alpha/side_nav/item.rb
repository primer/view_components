# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class SideNav
      # Doc this at some point
      class Item < Primer::Component
        LEADING_VISUAL_OPTIONS = %i(avatar icon).freeze
        TRAILING_VISUAL_OPTIONS = %i(icon label counter).freeze

        # @param component_name [Symbol] <%= one_of(Primer::Alpha::SideNav::Item::LEADING_VISUAL_OPTIONS) %>
        # @param kwargs [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %> or <%= link_to_component(Primer::OcticonComponent) %>
        renders_one :leading_visual, lambda { |component_name, **kwargs|
          case component_name
          when :avatar
            Primer::Beta::Avatar.new(**{ **kwargs, size: 16 })
          when :icon
            Primer::OcticonComponent.new(**kwargs)
          else
            raise ArgumentError, "Leading visual must be one of #{LEADING_VISUAL_OPTIONS.map(&:inspect).join(', ')}, got #{component_name.inspect} instead"
          end
        }

        # @param component_name [Symbol] <%= one_of(Primer::Alpha::SideNav::Item::TRAILING_VISUAL_OPTIONS) %>
        # @param kwargs [Hash] The arguments accepted by <%= link_to_component(Primer::OcticonComponent) %>, <%= link_to_component(Primer::LabelComponent) %> or  <%= link_to_component(Primer::CounterComponent) %>.
        renders_one :trailing_visual, lambda { |component_name, **kwargs|
          case component_name
          when :icon
            Primer::OcticonComponent.new(**kwargs)
          when :label
            Primer::LabelComponent.new(**kwargs)
          when :counter
            Primer::CounterComponent.new(**kwargs)
          else
            raise ArgumentError, "Trailing visual must be one of #{TRAILING_VISUAL_OPTIONS.map(&:inspect).join(', ')}, got #{component_name.inspect} instead"
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
