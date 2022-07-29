# frozen_string_literal: true

module Primer
  module Alpha
    class SegmentedControl
      # `SegmentedControl::Button` is used inside `SegmentedControl` to render a button.
      class Button < Primer::Component
        status :alpha

        # Leading visuals appear to the left of the button text.
        #
        # Use:
        #
        # - `leading_visual_icon` for a <%= link_to_component(Primer::OcticonComponent) %>.
        #
        # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
        renders_one :leading_visual, types: {
          icon: lambda { |**system_arguments|
            system_arguments[:classes] = "SegmentedControl-leadingVisual"

            Primer::OcticonComponent.new(system_arguments[:icon], **system_arguments)
          }
        }

        def initialize(text:, icon_only: false, selected: false, **system_arguments)
          @text = text
          @icon_only = icon_only
          @system_arguments = system_arguments
          @system_arguments[:tag] = :button
          @system_arguments[:id] = system_arguments[:id] || "segmented-control-button-#{text.downcase.gsub(/\s+/, '-')}" if render_tooltip?
          @system_arguments[:classes] = class_names(
            "SegmentedControl-button",
            @system_arguments[:classes],
            "SegmentedControl-button--selected": selected
          )
          @system_arguments[:'aria-selected'] = true if selected
        end

        private

        def render_tooltip?
          @icon_only != false
        end

        def render_text?
          @icon_only != true
        end
      end
    end
  end
end
