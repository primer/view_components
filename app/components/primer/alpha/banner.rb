# frozen_string_literal: true

module Primer
  module Alpha
    # Use `Banner` to highlight important information.
    #
    # ### Events
    #
    # |Name      |Type                |Bubbles |Cancelable |
    # |:---------|:-------------------|:-------|:----------|
    # |`dismiss` |`CustomEvent<void>` |No      |No         |
    #
    # @accessibility
    #  ### Improve discoverability with a heading and landmark
    #  Banners are made visually prominent with icons and colors to immediately draw attention.
    #
    #  To ensure the Banner is also easily discoverable for assistive technology users, consider:
    #  1. Providing a heading inside of the Banner that describes the purpose of the Banner.
    #  2. Designating the Banner as a `region` landmark. This can be achieved by rendering the Banner as a `section`  with an `aria-labelledby` pointing to the heading.
    #
    #  ### Communicating feedback
    #  When a Banner is used to communicate feedback, a live region or focus management technique should be in place to ensure that assistive technology users are aware of the feedback, especially when the Banner is shown client-side. Visit the [Banner's Accessibility section](https://primer.style/components/banner#accessibility), or defer to the accessibility team.
    #
    #  #### Approach 1: Announcing a Banner
    #  A live region announcement can be used to communicate non-critical feedback, such as a success message.
    #
    #  To successfully trigger a live region announcement for a Banner that is un-`hidden` or dynamically injected onto the page, **do not** set the live region attribute/role on the Banner itself. Instead, it's important to rely on a live region that is already guaranteed to be on the page. Learn more about specific techniques at: [Staff only: Challenges with live regions](https://github.com/github/accessibility/blob/main/docs/coaching-recommendations/toast-flash-banner/accessible-banner-prototype.md#challenges-with-dynamically-inserted-live-region).
    #
    #  #### Approach 2: Focusing a Banner
    #  Focusing the Banner can be appropriate for critical feedback scenarios, such as a [form validation error summary](https://primer.style/ui-patterns/forms/overview#interactive-summary-of-errors) where the Banner contains actions to help unblock the user.
    #
    #  To properly focus a Banner, add a `tabindex="-1"` place focus with JavaScript (using the [`focus()` API](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/focus)).
    class Banner < Primer::Component
      status :alpha

      # A button or custom content that will render on the right-hand side of the component.
      #
      # To render a button, call the `with_action_button` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Button) %>.
      #
      # To render custom content, call the `with_action_content` method and pass a block that returns HTML.
      renders_one :action, types: {
        button: lambda { |**system_arguments|
          deny_tag_argument(**system_arguments)

          Primer::Beta::Button.new(**system_arguments)
        },

        content: lambda { |**system_arguments|
          deny_tag_argument(**system_arguments)
          system_arguments[:tag] = :div

          Primer::BaseComponent.new(**system_arguments)
        }
      }

      DEFAULT_TAG = :div
      TAG_OPTIONS = [DEFAULT_TAG, :section].freeze

      DEFAULT_SCHEME = :default
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => "",
        :warning => "Banner--warning",
        :danger => "Banner--error",
        :success => "Banner--success"
      }.freeze

      LEGACY_SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => "",
        :warning => "flash-warn",
        :danger => "flash-error",
        :success => "flash-success"
      }.freeze

      DEFAULT_ICONS = {
        default: :bell,
        warning: :alert,
        danger: :stop,
        success: :"check-circle"
      }.freeze

      DEFAULT_DISMISS_SCHEME = :none
      DISMISS_SCHEMES = [
        DEFAULT_DISMISS_SCHEME,
        :remove,
        :hide
      ].freeze

      DEFAULT_DISMISS_LABEL = "Dismiss"

      # @param tag [Symbol] <%= one_of(Primer::Alpha::Banner::TAG_OPTIONS) %>
      # @param full [Boolean] Whether the component should take up the full width of the screen.
      # @param full_when_narrow [Boolean] Whether the component should take up the full width of the screen when rendered inside smaller viewports.
      # @param dismiss_scheme [Symbol] Whether the component can be dismissed with an "x" button. <%= one_of(Primer::Alpha::Banner::DISMISS_SCHEMES) %>
      # @param dismiss_label [String] The aria-label text of the dismiss "x" button
      # @param description [String] Description text rendered underneath the message.
      # @param icon [Symbol] The name of an <%= link_to_octicons %> icon to use. If no icon is provided, a default one will be chosen based on the scheme.
      # @param scheme [Symbol] <%= one_of(Primer::Alpha::Banner::SCHEME_MAPPINGS.keys) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(tag: DEFAULT_TAG, full: false, full_when_narrow: false, dismiss_scheme: DEFAULT_DISMISS_SCHEME, dismiss_label: DEFAULT_DISMISS_LABEL, description: nil, icon: nil, scheme: DEFAULT_SCHEME, **system_arguments)
        @scheme = fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme, DEFAULT_SCHEME)
        @icon = icon || DEFAULT_ICONS[@scheme]
        @dismiss_scheme = dismiss_scheme
        @dismiss_label = dismiss_label
        @description = description

        @system_arguments = system_arguments
        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "Banner",
          "flash", # legacy
          SCHEME_MAPPINGS[@scheme],
          LEGACY_SCHEME_MAPPINGS[@scheme],
          "Banner--full": full,
          "flash-full": full, # legacy
          "Banner--full-whenNarrow": full_when_narrow
        )

        @message_arguments = {
          tag: :div,
          classes: "Banner-message"
        }

        @wrapper_arguments = {
          tag: custom_element_name,
          data: { dismiss_scheme: @dismiss_scheme }
        }
      end

      private

      def custom_element_name
        "x-banner"
      end

      def catalyst_action(event:, function:)
        "#{event}:#{custom_element_name}##{function}"
      end

      def catalyst_target(field:)
        "#{custom_element_name}.#{field}"
      end
    end
  end
end
