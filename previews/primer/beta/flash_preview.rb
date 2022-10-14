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
      # @param icon [Symbol] select [none, alert, check, info, people]
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      # @param description text
      def playground(full: false, full_when_narrow: false, dismissible: false, icon: :people, scheme: Primer::Beta::Flash::DEFAULT_SCHEME, content: "This is a flash message!", description: nil)
        render(Primer::Beta::Flash.new(full: full, full_when_narrow: full_when_narrow, dismissible: dismissible, icon: icon == :none ? nil : icon, scheme: scheme, description: description)) { content }
      end

      # @label With action button
      #
      # @param full toggle
      # @param dismissible toggle
      # @param icon [Symbol] select [alert, check, info, people]
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      def with_action(full: false, dismissible: false, icon: :people, scheme: Primer::Beta::Flash::DEFAULT_SCHEME, content: "This is a flash message with an action!")
        render_with_template(locals: { full: full, dismissible: dismissible, icon: icon == :none ? nil : icon, scheme: scheme, content: content })
      end

      def action_button
        render(Primer::Beta::Flash.new) do |c|
          "This is broken"
          c.action do |c|
            "Take action"
          end
        end
      end
    end
  end
end
