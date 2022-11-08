# frozen_string_literal: true

module Primer
  module Alpha
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
      def playground(full: false, full_when_narrow: false, dismissible: false, icon: :people, scheme: Primer::Alpha::Banner::DEFAULT_SCHEME, reappear: true, content: "This is a banner!", description: nil)
        icon = nil if icon == :none
        render(Primer::Alpha::Banner.new(full: full, full_when_narrow: full_when_narrow, dismissible: dismissible, icon: icon == :none ? nil : icon, scheme: scheme, description: description, reappear: reappear)) { content }
      end

      # @label Default
      def default
        render(Primer::Alpha::Banner.new) { "This is a banner!" }
      end

      # @label With action button
      #
      # @param full toggle
      # @param dismissible toggle
      # @param icon [Symbol] octicon
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      # @param reappear [Boolean]
      def with_action_button(full: false, dismissible: false, icon: :people, scheme: Primer::Alpha::Banner::DEFAULT_SCHEME, reappear: true, content: "This is a banner with an action!")
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
      def with_action_content(full: false, dismissible: false, icon: :people, scheme: Primer::Alpha::Banner::DEFAULT_SCHEME, reappear: true, content: "Did you know? Comments can be edited.")
        icon = nil if icon == :none
        render_with_template(locals: { full: full, dismissible: dismissible, icon: icon == :none ? nil : icon, scheme: scheme, content: content, reappear: reappear })
      end
    end
  end
end
