# frozen_string_literal: true

module Primer
  module Alpha
    class SegmentedControl
      # SegmentedControl::Item is a private component that is only used by SegmentedControl
      # It wraps the Button and IconButton components to provide the correct styles
      class Item < Primer::BaseComponent
        include ViewComponent::InlineTemplate

        status :alpha
        audited_at "2023-02-01"

        erb_template <<~ERB
          <li class="<%= class_names(
            "SegmentedControl-item",
            "SegmentedControl-item--selected": @selected
            ) %>" role="listitem" data-targets="segmented-control.items">
            <% if @hide_labels %>
              <%= render Primer::Beta::IconButton.new(icon: @icon, "aria-label": @label, **@system_arguments) %>
            <% else %>
              <%= render Primer::Beta::Button.new(**@system_arguments) do |button| %>
                <% button.with_leading_visual_icon(icon: @icon) unless @icon.nil? %>
                <%= @label %>
              <% end %>
            <% end %>
          </li>
        ERB

        # @param label [String] The label to use
        # @param selected [Boolean] Whether the item is selected
        # @param icon [Symbol] The icon to use
        # @param hide_labels [Symbol] Whether to only show the icon
        def initialize(label:, selected: false, icon: nil, hide_labels: false, **system_arguments)
          @icon = icon
          @hide_labels = hide_labels
          @label = label
          @selected = selected

          @system_arguments = system_arguments
          @system_arguments[:"data-action"] = "click:segmented-control#select" if system_arguments[:href].nil?
          @system_arguments[:"aria-current"] = selected
          @system_arguments[:scheme] = :invisible
        end
      end
    end
  end
end
