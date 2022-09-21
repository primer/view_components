# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class SegmentedControl < Primer::Component
      status :alpha

      FULL_WIDTH_DEFAULT = false

      ICON_ONLY_DEFAULT = :never
      ICON_ONLY_MAPPINGS = {
        ICON_ONLY_DEFAULT => "",
        :always => "SegmentedControl-button--iconOnly",
        :when_narrow => "SegmentedControl-button--iconOnly-whenNarrow"
      }.freeze
      ICON_ONLY_OPTIONS = ICON_ONLY_MAPPINGS.keys

      # Use to render a button and an associated panel slot. See the example below or refer to <%= link_to_component(Primer::Navigation::TabComponent) %>.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :buttons, lambda { |selected: false, icon: nil, **system_arguments|
        Primer::Alpha::SegmentedControl::Button.new(selected: selected, icon: icon, icon_only: @icon_only, **system_arguments)
      }

      # @example Basic usage
      #
      #   <%= render(Primer::Alpha::SegmentedControl.new) do |c| %>
      #     <%= c.with_button(selected: true) { "Preview" } %>
      #     <%= c.with_button { "Raw" } %>
      #     <%= c.with_button { "Blame" } %>
      #   <% end %>
      #
      # @example With icons
      #   <%= render(Primer::Alpha::SegmentedControl.new) do |c| %>
      #     <%= c.with_button(icon: :eye, selected: true) { "Preview" } %>
      #     <%= c.with_button(icon: :"file-code") { "Raw" } %>
      #     <%= c.with_button(icon: :people) { "Blame" } %>
      #   <% end %>
      #
      # @example With icons only
      #   <%= render(Primer::Alpha::SegmentedControl.new(icon_only: :always)) do |c| %>
      #     <%= c.with_button(icon: :eye, selected: true) { "Preview" } %>
      #     <%= c.with_button(icon: :"file-code") { "Raw" } %>
      #     <%= c.with_button(icon: :people) { "Blame" } %>
      #   <% end %>
      #
      # @example With icons only when narrow
      #   <%= render(Primer::Alpha::SegmentedControl.new(icon_only: :when_narrow)) do |c| %>
      #     <%= c.with_button(icon: :eye, selected: true) { "Preview" } %>
      #     <%= c.with_button(icon: :"file-code") { "Raw" } %>
      #     <%= c.with_button(icon: :people) { "Blame" } %>
      #   <% end %>
      #
      # @example Fill width of parent
      #   <%= render(Primer::Alpha::SegmentedControl.new(full_width: true)) do |c| %>
      #     <%= c.with_button(icon: :eye, selected: true) { "Preview" } %>
      #     <%= c.with_button(icon: :"file-code") { "Raw" } %>
      #     <%= c.with_button(icon: :people) { "Blame" } %>
      #   <% end %>
      #
      # @param icon_only [Symbol] <%= one_of(Primer::Alpha::SegmentedControl::ICON_ONLY_OPTIONS) %>
      # @param full_width [Boolean] If the component should be full width
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(icon_only: ICON_ONLY_DEFAULT, full_width: FULL_WIDTH_DEFAULT, **system_arguments)
        @icon_only = fetch_or_fallback(ICON_ONLY_OPTIONS, icon_only, ICON_ONLY_DEFAULT)
        @system_arguments = system_arguments
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "SegmentedControl",
          ICON_ONLY_MAPPINGS[icon_only],
          "SegmentedControl--fullWidth": full_width
        )
      end

      # SegmentedControl::Button is a private component that is only used by SegmentedControl
      # It wraps the Button and IconButton components to provide the correct styles
      class Button < Primer::BaseComponent
        attr_reader :selected

        def initialize(icon: nil, selected: false, icon_only: ICON_ONLY_DEFAULT, **system_arguments)
          @selected = selected
          @icon_only = fetch_or_fallback(ICON_ONLY_OPTIONS, icon_only, ICON_ONLY_DEFAULT)
          @system_arguments = system_arguments
          @system_arguments[:classes] = class_names(
            "SegmentedControl-item--selected": selected
          )
          @system_arguments[:"data-action"] = "click:segmented-control#select"
          @system_arguments[:"aria-current"] = selected
          @icon = icon
        end
      end
    end
  end
end
