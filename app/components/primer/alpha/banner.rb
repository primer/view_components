# frozen_string_literal: true

module Primer
  module Alpha
    # Use `Banner` to highlight important information.
    #
    # @accessibility
    #   Given that Banner is made visually prominent to sighted users through the use of icons and color, consider providing a heading and designating the Banner as a region landmark to improve navigability and discoverability of the Banner of assistive technology users. At this time, the PVC Banner does not render a heading nor render as a region landmark by default. This may be introduced in the future [as a breaking API change](https://github.com/primer/view_components/issues/2619). For now, consider providing an appropriate heading inside of the Banner and rendering the Banner as a `<section>` tag with `aria-labelledby="switch-this-with-banner-heading-id"` to implicitly designate the Banner as a region landmark.
    #
    #   A Banner can be used in one of two ways – to highlight information on a page, or to communicate an urgent message/feedback for a user action. For the latter scenario, it may be necessary to use a live region or focus management technique to ensure that the Banner is discoverable and accessible for all users. Otherwise, the Banner can easily be missed, including by those using magnification software or screen reader users who may not realize that a Banner has appeared. The appropriate technique to use is highly context-dependent. Visit the [Banner's Accessibility section](https://primer.style/components/banner#accessibility) or defer to the accessibility team to determine if your scenario requires either techniques.
    #
    #   ### Announcing a Banner
    #     When a Banner is used to communicate non-critical feedback, or is used in critical scenarios where moving focus is considered too disruptive, use a live region announcement to announce the content of the Banner to screen reader users.
    #
    #     Live regions can be finicky and don't work well when injected dynamically. Setting a live region attribute on the Banner itself is discouraged as it will not announce as expected for most screen readers.
    #
    #     To ensure a Banner is announced reliably, make sure that there's a live region container that is already on the page. When the Banner is shown, populate the live region container with the content of the Banner. This can be done in one of two ways. The first is to rely on a global live region container that is guaranteed to be on the page. When the Banner appears, populate this global live region container with the Banner content. The second technique is to hide or show the Banner within a live region wrapper that is guaranteed to always be on the page.
    #
    #     For more information about either techniques, visit [Staff only: Challenges with live regions](https://github.com/github/accessibility/blob/main/docs/coaching-recommendations/toast-flash-banner/accessible-banner-prototype.md#challenges-with-dynamically-inserted-live-region). This guidance is subject to change.
    #
    #   ### Focusing a Banner
    #     Focusing a Banner when it appears helps to maximize discoverability of the message, especially in critical scenarios.
    #
    #     To properly focus a banner, add a `tabindex="-1"` to the Banner container, and focus that container (one way is using the [`focus()` API](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/focus)).
    #
    #     For more information about the focus management technique, visit the [Staff only: Accessible Banner Prototype docs](https://github.com/github/accessibility/blob/main/docs/coaching-recommendations/toast-flash-banner/accessible-banner-prototype.md#consideration). This guidance is subject to change.
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
