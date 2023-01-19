# frozen_string_literal: true

module Primer
  module Beta
    # Use `CloseButton` to render an `×` without default button styles.
    #
    # @accessibility
    #   `CloseButton` has a default `aria-label` of "Close" to provides assistive technologies with an accessible label.
    #   You may choose to override this label with something more descriptive via [system_arguments][0].
    # [0]: https://primer.style/view-components/system-arguments#html-attributes
    class CloseButton < Primer::Component
      status :beta

      DEFAULT_TYPE = :button
      TYPE_OPTIONS = [DEFAULT_TYPE, :submit].freeze

      # @example Default
      #   <%= render(Primer::Beta::CloseButton.new) %>
      #
      # @param type [Symbol] <%= one_of(Primer::Beta::CloseButton::TYPE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(type: DEFAULT_TYPE, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :button
        @system_arguments[:block] = false
        @system_arguments[:type] = fetch_or_fallback(TYPE_OPTIONS, type, DEFAULT_TYPE)
        @system_arguments[:classes] = class_names(
          "close-button",
          system_arguments[:classes]
        )
        @system_arguments[:"aria-label"] ||= "Close"
      end

      def call
        render(Primer::Beta::BaseButton.new(**@system_arguments)) do
          render(Primer::Beta::Octicon.new("x"))
        end
      end
    end
  end
end
