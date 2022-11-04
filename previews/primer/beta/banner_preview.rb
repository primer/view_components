# frozen_string_literal: true

module Primer
  module Beta
    # @label Banner
    class BannerPreview < ViewComponent::Preview
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
      def playground(full: false, full_when_narrow: false, dismissible: false, icon: :people, scheme: Primer::Beta::Banner::DEFAULT_SCHEME, reappear: true, content: "This is a banner!", description: nil)
        icon = nil if icon == :none
        render(Primer::Beta::Banner.new(full: full, full_when_narrow: full_when_narrow, dismissible: dismissible, icon: icon == :none ? nil : icon, scheme: scheme, description: description, reappear: reappear)) { content }
      end

      # @label Default
      def default
        render(Primer::Beta::Banner.new) { "This is a banner!" }
      end

      # @label Danger
      def as_danger
        render(Primer::Beta::Banner.new(scheme: :danger)) { "This is a danger banner!" }
      end

      # @label Success
      def as_success
        render(Primer::Beta::Banner.new(scheme: :success)) { "This is a success banner!" }
      end

      # @label Warning
      def as_warning
        render(Primer::Beta::Banner.new(scheme: :warning)) { "This is a warning banner!" }
      end

      # @label Full width
      def full_width
        render(Primer::Beta::Banner.new(full: true)) { "This is a full width banner." }
      end

      # @label Full width in Narrow Viewport
      def full_width_in_narrow_viewport
        render(Primer::Beta::Banner.new(full: true, full_when_narrow: true)) { "This is a full width banner in a narrow viewport." }
      end

      # @label With action button
      #
      # @param full toggle
      # @param dismissible toggle
      # @param icon [Symbol] octicon
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      # @param reappear [Boolean]
      def with_action_button(full: false, dismissible: false, icon: :people, scheme: Primer::Beta::Banner::DEFAULT_SCHEME, reappear: true, content: "This is a banner with an action!")
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
      def with_action_content(full: false, dismissible: false, icon: :people, scheme: Primer::Beta::Banner::DEFAULT_SCHEME, reappear: true, content: "Did you know? Comments can be edited.")
        icon = nil if icon == :none
        render_with_template(locals: { full: full, dismissible: dismissible, icon: icon == :none ? nil : icon, scheme: scheme, content: content, reappear: reappear })
      end
    end
  end
end
