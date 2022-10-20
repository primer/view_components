# frozen_string_literal: true

module Primer
  module Beta
    # @label Flash
    class FlashPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param full toggle
      # @param full_when_narrow toggle
      # @param dismissible toggle
      # @param icon [Symbol] octicon
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      # @param description text
      # @param reappear [Boolean]
      def playground(full: false, full_when_narrow: false, dismissible: false, icon: :people, scheme: Primer::Beta::Flash::DEFAULT_SCHEME, reappear: true, content: "This is a flash message!", description: nil)
        icon = nil if icon == :none
        render(Primer::Beta::Flash.new(full: full, full_when_narrow: full_when_narrow, dismissible: dismissible, icon: icon == :none ? nil : icon, scheme: scheme, description: description, reappear: reappear)) { content }
      end

      # @label Default
      def default
        render(Primer::Beta::Flash.new) { "This is a flash message!" }
      end

      # @label With action button
      #
      # @param full toggle
      # @param dismissible toggle
      # @param icon [Symbol] octicon
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      # @param reappear [Boolean]
      def with_action_button(full: false, dismissible: false, icon: :people, scheme: Primer::Beta::Flash::DEFAULT_SCHEME, reappear: true, content: "This is a flash message with an action!")
        icon = nil if icon == :none
        render_with_template(locals: { full: full, dismissible: dismissible, icon: icon == :none ? nil : icon, scheme: scheme, content: content, reappear: reappear })
      end

      # @label With action content
      #
      # @param full toggle
      # @param dismissible toggle
      # @param icon [Symbol] octicon
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      # @param reappear [Boolean]
      def with_action_content(full: false, dismissible: false, icon: :people, scheme: Primer::Beta::Flash::DEFAULT_SCHEME, reappear: true, content: "Comment saved!")
        icon = nil if icon == :none
        render_with_template(locals: { full: full, dismissible: dismissible, icon: icon == :none ? nil : icon, scheme: scheme, content: content, reappear: reappear })
      end
    end
  end
end
