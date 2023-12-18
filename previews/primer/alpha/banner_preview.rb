# frozen_string_literal: true

module Primer
  module Alpha
    # @label Banner
    class BannerPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param full toggle
      # @param full_when_narrow toggle
      # @param dismiss_scheme [Symbol] select [none, remove, hide]
      # @param dismiss_label text
      # @param icon [Symbol] octicon
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      # @param description text
      def playground(full: false, full_when_narrow: false, dismiss_scheme: Primer::Alpha::Banner::DEFAULT_DISMISS_SCHEME,  dismiss_label: Primer::Alpha::Banner::DEFAULT_DISMISS_LABEL, icon: :people, scheme: Primer::Alpha::Banner::DEFAULT_SCHEME, content: "This is a banner!", description: nil)
        icon = nil if icon == :none
        render(Primer::Alpha::Banner.new(full: full, full_when_narrow: full_when_narrow, dismiss_scheme: dismiss_scheme, dismiss_label: dismiss_label, icon: icon == :none ? nil : icon, scheme: scheme, description: description)) { content }
      end

      # @label Default
      def default
        render(Primer::Alpha::Banner.new) { "This is a banner." }
      end

      # @!group Schemes
      #
      # @label Default scheme
      # @snapshot
      def scheme_default
        render(Primer::Alpha::Banner.new) { "This is a default banner." }
      end

      # @label Danger
      # @snapshot
      def scheme_danger
        render(Primer::Alpha::Banner.new(scheme: :danger)) { "This is a danger banner!" }
      end

      # @label Success
      # @snapshot
      def scheme_success
        render(Primer::Alpha::Banner.new(scheme: :success)) { "This is a success banner!" }
      end

      # @label Warning
      # @snapshot
      def scheme_warning
        render(Primer::Alpha::Banner.new(scheme: :warning)) { "This is a warning banner!" }
      end
      #
      # @!endgroup

      # @label Dismissable
      # @snapshot
      def dismissible
        render(Primer::Alpha::Banner.new(dismiss_scheme: :hide, reappear: true)) { "This is a dismissable banner." }
      end

      # @!group Full Width
      # @snapshot
      #
      # @label Full width
      def full_width
        render(Primer::Alpha::Banner.new(full: true)) { "This is a full width banner." }
      end

      # @label Full width in Narrow Viewport
      def full_width_in_narrow_viewport
        render(Primer::Alpha::Banner.new(full: true, full_when_narrow: true)) { "This is a full width banner in a narrow viewport." }
      end
      #
      # @!endgroup

      # @label With action button
      #
      # @param full toggle
      # @param dismiss_scheme [Symbol] select [none, remove, hide]
      # @param icon [Symbol] octicon
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      # @snapshot
      def with_action_button(full: false, dismiss_scheme: Primer::Alpha::Banner::DEFAULT_DISMISS_SCHEME, icon: :people, scheme: Primer::Alpha::Banner::DEFAULT_SCHEME, content: "This is a banner with an action!")
        icon = nil if icon == :none
        render_with_template(locals: { full: full, dismiss_scheme: dismiss_scheme, icon: icon == :none ? nil : icon, scheme: scheme, content: content })
      end

      # @label With action content
      #
      # @param full toggle
      # @param dismiss_scheme [Symbol] select [none, remove, hide]
      # @param icon [Symbol] octicon
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      # @snapshot
      def with_action_content(full: false, dismiss_scheme: Primer::Alpha::Banner::DEFAULT_DISMISS_SCHEME, icon: :people, scheme: Primer::Alpha::Banner::DEFAULT_SCHEME, content: "Did you know? Comments can be edited.")
        icon = nil if icon == :none
        render_with_template(locals: { full: full, dismiss_scheme: dismiss_scheme, icon: icon == :none ? nil : icon, scheme: scheme, content: content })
      end
    end
  end
end
