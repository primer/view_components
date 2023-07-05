# frozen_string_literal: true

module Primer
  module Beta
    # @label Flash
    class FlashPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param full toggle
      # @param spacious toggle
      # @param dismissible toggle
      # @param icon [Symbol] select [alert, check, info, people]
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      def playground(full: false, spacious: false, dismissible: false, icon: :people, scheme: Primer::Beta::Flash::DEFAULT_SCHEME, content: "This is a flash message!")
        render(Primer::Beta::Flash.new(full: full, spacious: spacious, dismissible: dismissible, icon: icon, scheme: scheme)) { content }
      end

      # @label Default
      # @snapshot
      #
      def default
        render(Primer::Beta::Flash.new) { "This is a flash message!" }
      end

      # @!group Color Schemes
      #
      # @label Default
      # @snapshot
      def color_scheme_default
        render(Primer::Beta::Flash.new) { "This is a flash message!" }
      end

      # @label Warning
      # @snapshot
      def color_scheme_warning
        render(Primer::Beta::Flash.new(scheme: :warning)) { "This is a warning flash message!" }
      end

      # @label Danger
      # @snapshot
      def color_scheme_danger
        render(Primer::Beta::Flash.new(scheme: :danger)) { "This is a danger flash message!" }
      end

      # @label Success
      # @snapshot
      def color_scheme_success
        render(Primer::Beta::Flash.new(scheme: :success)) { "This is a success flash message!" }
      end
      #
      # @!endgroup

      # @!group More options
      #
      # @label Full width
      # @snapshot
      def options_full
        render(Primer::Beta::Flash.new(full: true)) { "This is a full width flash message!" }
      end

      # @label Dismissible
      # @snapshot
      def options_dismissible
        render(Primer::Beta::Flash.new(dismissible: true)) { "This is a dismissible flash message!" }
      end

      # @label With icon
      # @snapshot
      def options_with_icon
        render(Primer::Beta::Flash.new(icon: :info)) { "This is a flash message with an icon!" }
      end
      #
      # @!endgroup
    end
  end
end
