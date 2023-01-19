# frozen_string_literal: true

module Primer
  module Beta
    # @label ClipboardCopy
    class ClipboardCopyPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param aria_label [String]
      # @param value [String]
      def playground(value: "Text to copy", aria_label: "Copy text to the system clipboard")
        render(Primer::Beta::ClipboardCopy.new(value: value, "aria-label": aria_label))
      end

      # @label Default Options
      #
      # @param aria_label [String]
      # @param value [String]
      def default(value: "Text to copy", aria_label: "Copy text to the system clipboard")
        render(Primer::Beta::ClipboardCopy.new(value: value, "aria-label": aria_label))
      end

      # @label With text instead of icons
      #
      # @param aria_label [String]
      # @param value [String]
      def text(value: "Text to copy", aria_label: "Click to copy!")
        render(Primer::Beta::ClipboardCopy.new(value: value, "aria-label": aria_label)) { "Click to copy!" }
      end

      # @label Copying from an element
      #
      # @param aria_label [String]
      def element(aria_label: "Copy text to the system clipboard")
        render_with_template(locals: { aria_label: aria_label })
      end
    end
  end
end
