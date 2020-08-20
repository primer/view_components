# frozen_string_literal: true

module Primer
  class ButtonComponent < Primer::Component
    DEFAULT_BUTTON_TYPE = :default
    BUTTON_TYPE_MAPPINGS = {
      DEFAULT_BUTTON_TYPE => "",
      :primary => "btn-primary",
      :danger => "btn-danger",
      :outline => "btn-outline"
    }.freeze
    BUTTON_TYPE_OPTIONS = BUTTON_TYPE_MAPPINGS.keys

    DEFAULT_VARIANT = :medium
    VARIANT_MAPPINGS = {
      :small => "btn-sm",
      DEFAULT_VARIANT => "",
      :large => "btn-large",
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys

    DEFAULT_TAG = :button
    TAG_OPTIONS = [DEFAULT_TAG, :a].freeze

    DEFAULT_TYPE = :button
    TYPE_OPTIONS = [DEFAULT_TYPE, :reset, :submit].freeze

    def initialize(
      button_type: DEFAULT_BUTTON_TYPE,
      variant: DEFAULT_VARIANT,
      tag: DEFAULT_TAG,
      type: DEFAULT_TYPE,
      group_item: false,
      **kwargs
    )
      @kwargs = kwargs
      @kwargs[:tag] = fetch_or_fallback(TAG_OPTIONS, tag.to_sym, DEFAULT_TAG)

      if @kwargs[:tag] == :a
        @kwargs[:role] = :button
      else
        @kwargs[:type] = type.to_sym
      end

      @kwargs[:classes] = class_names(
        "btn",
        kwargs[:classes],
        BUTTON_TYPE_MAPPINGS[fetch_or_fallback(BUTTON_TYPE_OPTIONS, button_type.to_sym, DEFAULT_BUTTON_TYPE)],
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant.to_sym, DEFAULT_VARIANT)],
        "BtnGroup-item" => group_item
      )
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
