# frozen_string_literal: true

module Primer
  module Alpha
    # Use `ButtonMarketing` for actions (e.g. in forms). Use links for destinations, or moving from one page to another.
    # @accessibility
    #   Setting the tag argument to `:a:` requires you to pass in an `href` attribute.
    class ButtonMarketing < Primer::Component
      DEFAULT_SCHEME = :default
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => "",
        :primary => "btn-signup-mktg",
        :outline => "btn-muted-mktg",
        :transparent => "btn-subtle-mktg"
      }.freeze
      SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

      DEFAULT_VARIANT = :default
      VARIANT_MAPPINGS = {
        DEFAULT_VARIANT => "",
        :large => "btn-large-mktg"
      }.freeze
      VARIANT_OPTIONS = VARIANT_MAPPINGS.keys

      DEFAULT_TAG = :button
      TAG_OPTIONS = [DEFAULT_TAG, :a].freeze

      DEFAULT_TYPE = :button
      TYPE_OPTIONS = [DEFAULT_TYPE, :submit].freeze

      # @param scheme [Symbol] <%= one_of(Primer::Alpha::ButtonMarketing::SCHEME_OPTIONS) %>
      # @param variant [Symbol] <%= one_of(Primer::Alpha::ButtonMarketing::VARIANT_OPTIONS) %>
      # @param tag [Symbol] <%= one_of(Primer::Alpha::ButtonMarketing::TAG_OPTIONS) %>
      # @param type [Symbol] <%= one_of(Primer::Alpha::ButtonMarketing::TYPE_OPTIONS) %>
      # @param disabled [Boolean] Whether or not the button is disabled. If true, this option forces `tag:` to `:button`.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        scheme: DEFAULT_SCHEME,
        variant: DEFAULT_VARIANT,
        tag: DEFAULT_TAG,
        type: DEFAULT_TYPE,
        disabled: false,
        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:block] = false
        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
        @system_arguments[:type] = fetch_or_fallback(TYPE_OPTIONS, type, DEFAULT_TYPE)
        @system_arguments[:classes] = class_names(
          "btn-mktg",
          SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)],
          VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant, DEFAULT_VARIANT)],
          system_arguments[:classes]
        )
        @system_arguments[:disabled] = disabled
      end

      def call
        render(Primer::Beta::BaseButton.new(**@system_arguments)) { content }
      end
    end
  end
end
