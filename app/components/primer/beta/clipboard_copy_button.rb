# frozen_string_literal: true

module Primer
  module Beta
    # `ClipboardCopyButton` uses `ClipboardCopy` to copy text to the clipboard, styled as a Primer button.
    class ClipboardCopyButton < Primer::Component
      def initialize(**system_arguments)
        @system_arguments = system_arguments
      end

      def call
        render(Primer::Beta::Button.new(base_button_class: ClipboardCopyBaseButton, **@system_arguments))
      end
    end

    # Internal
    #
    # :nodoc:
    class ClipboardCopyBaseButton < Primer::Beta::BaseButton
      def call
        render(Primer::Beta::ClipboardCopy.new(**@system_arguments))
      end
    end
  end
end
