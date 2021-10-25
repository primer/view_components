# frozen_string_literal: true

module Primer
  module Alpha
    # `Tooltip` is a wrapper component that will apply a tooltip to the provided content.
    class Tooltip < Primer::Component
      status :alpha

      TOOLTIP_TYPE = [:describe, :label].freeze

      # @example Default
      #   <div class="pt-5">
      #     <%= render(Primer::Alpha::Tooltip.new(id: "unique", type: :describe, text: "this is tooltip text", tabindex: 0)) { "Default Bold Text" } %>
      #   </div>
      #
      # @example with icon
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique", type: :label, text: "this is the best"))  do %>
      #     <%= render Primer::OcticonComponent.new(:copy, tabindex: 0) %>
      #   <% end %>
      #
      # @param id [String] unique id
      # @param type [Symbol] type of tooltip
      # @param text [String] the text to appear in the tooltip
      # @param direction [String] Direction of the tooltip. <%= one_of(Primer::Tooltip::DIRECTION_OPTIONS) %>
      # @param align [String] Align tooltips to the left or right of an element, combined with a `direction` to specify north or south. <%= one_of(Primer::Tooltip::ALIGN_MAPPING.keys) %>
      # @param multiline [Boolean] Use this when you have long content
      # @param no_delay [Boolean] By default the tooltips have a slight delay before appearing. Set true to override this
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        id:,
        type:,
        text:,
        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = :"tooltip-container"
        
        content_system_arguments = type == :describe ? { "aria-describedby": "#{id}-tooltip" } : { "aria-labelledby": "#{id}-tooltip"  }
        content_system_arguments[:id] = id
        @content_system_arguments = content_system_arguments.merge({ tag: :span, tabindex: 0 })

        @text = text
        @tooltip_system_arguments = { hidden: true, tag: :p, classes: "alpha-tooltipped", id: "#{id}-tooltip", role: "tooltip"}
      end
    end
  end
end