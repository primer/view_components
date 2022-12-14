# frozen_string_literal: true

module Primer
  module Beta
    # Use `ClipboardCopy` to copy element text content or input values to the clipboard.
    #
    # @accessibility
    #   Always set an accessible label to help the user interact with the component.
    class ClipboardCopy < Primer::Component
      status :beta

      # @example Default
      #   <%= render(Primer::Beta::ClipboardCopy.new(value: "Text to copy", "aria-label": "Copy text to the system clipboard")) %>
      #
      # @example With text instead of icons
      #   <%= render(Primer::Beta::ClipboardCopy.new(value: "Text to copy")) do %>
      #     Click to copy!
      #   <% end %>
      #
      # @example Copying from an element
      #   <%= render(Primer::Beta::ClipboardCopy.new(for: "blob-path", "aria-label": "Copy text to the system clipboard")) %>
      #   <div id="blob-path">src/index.js</div>
      #
      # @param aria-label [String] String that will be read to screenreaders when the component is focused
      # @param value [String] Text to copy into the users clipboard when they click the component.
      # @param for [String] Element id from where to get the copied value.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(value: nil, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @value = value

        validate!

        @system_arguments[:tag] = "clipboard-copy"
        @system_arguments[:value] = value if value.present?
      end

      # :nodoc:
      def before_render
        validate_aria_label if content.blank?
      end

      private

      def validate!
        raise ArgumentError, "Must provide either `value` or `for`" if @value.nil? && @system_arguments[:for].nil?
      end
    end
  end
end
