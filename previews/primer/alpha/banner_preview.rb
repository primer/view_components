# frozen_string_literal: true

module Primer
  module Alpha
    # @label Banner
    class BannerPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param full toggle
      # @param full_when_narrow toggle
      # @param centered_when_full toggle
      # @param dismissible toggle
      # @param icon [Symbol] octicon
      # @param scheme [Symbol] select [default, warning, danger, success]
      # @param content text
      # @param description text
      # @param reappear [Boolean]
      def playground(full: false, full_when_narrow: false, centered_when_full: false, dismissible: false, icon: :people, scheme: Primer::Alpha::Banner::DEFAULT_SCHEME, reappear: true, content: "This is a banner!", description: nil)
        icon = nil if icon == :none
        render(Primer::Alpha::Banner.new(full: full, full_when_narrow: full_when_narrow, centered_when_full: centered_when_full, dismissible: dismissible, icon: icon == :none ? nil : icon, scheme: scheme, description: description, reappear: reappear)) { content }
      end

      # @label Default
      def default
        render(Primer::Alpha::Banner.new) { "This is a banner." }
      end

      # @!group Schemes
      #
      # @label Default scheme
      def scheme_default
        render(Primer::Alpha::Banner.new) { "This is a default banner." }
      end

      # @label Danger
      def scheme_danger
        render(Primer::Alpha::Banner.new(scheme: :danger)) { "This is a danger banner!" }
      end

      # @label Success
      def scheme_success
        render(Primer::Alpha::Banner.new(scheme: :success)) { "This is a success banner!" }
      end

      # @label Warning
      def scheme_warning
        render(Primer::Alpha::Banner.new(scheme: :warning)) { "This is a warning banner!" }
      end
      #
      # @!endgroup

      # @label Dismissable
      def dismissable
        render(Primer::Alpha::Banner.new(dismissable: true, reappear: true)) { "This is a dismissable banner." }
      end

      # @!group Full Width
      #
      # @label Full width
      def full_width
        render(Primer::Alpha::Banner.new(full: true)) { "This is a full width banner." }
      end

      # @label Full width in Narrow Viewport
      def full_width_in_narrow_viewport
        render(Primer::Alpha::Banner.new(full: true, full_when_narrow: true)) { "This is a full width banner in a narrow viewport." }
      end

      # @label Full width with lots more content
      def full_width_with_lots_more_content
        render(Primer::Alpha::Banner.new(full: true)) { "This is a full width banner with a lot of content. It has a max-width to make sure that the text doesn't exceed too long and starts wrapping onto multiple lines." }
      end

      # @label Full width with dismissible
      def full_width_with_dismissible
        render(Primer::Alpha::Banner.new(full: true, dismissible: true)) { "This is a full width banner with a lot of content. It's dismissible. It has a max-width to make sure that the text doesn't exceed too long and starts wrapping onto multiple lines." }
      end

      # @label Full width with action button
      def full_width_with_action_button
        render(Primer::Alpha::Banner.new(full: true, dismissible: true)) do |component|
          component.with_action_button(size: :small) { "Take action" }
          "This is a full width banner with a lot of content. It's dismissible and has an action button. It has a max-width to make sure that the text does not exceed too long and starts wrapping onto multiple lines."
        end
      end

      # @label Full width with description
      def full_width_with_description
        render(
          Primer::Alpha::Banner.new(
            full: true,
            dismissible: true,
            description: "It also has a description that is long and wraps onto multiple lines. Not yet.. so I have to type some more, a lot more. Ok, I think now."
          )
        ) do |component|
          component.with_action_button(size: :small) { "Take action" }
          "This is a full width banner with a lot of content. It's dismissible and has an action button. It has a max-width to make sure that the text does not exceed too long and starts wrapping onto multiple lines."
        end
      end
      #
      # @!endgroup

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
