# frozen_string_literal: true

module Primer
  module Beta
    # @label ClipboardCopyButton
    class ClipboardCopyButtonPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param text [String]
      def playground(text: "Text to copy")
        render(Primer::Beta::ClipboardCopyButton.new(id: "clipboard-button", aria: { label: "Copy" }, value: text))
      end

      # @label With tooltip
      # @snapshot
      def with_tooltip
        render(Primer::Beta::ClipboardCopyButton.new(id: "clipboard-button", aria: { label: "Copy" }, value: "Text to copy")) do |button|
          button.with_tooltip(text: "Copy some text")
        end
      end
    end
  end
end
