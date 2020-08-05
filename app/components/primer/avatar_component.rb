# frozen_string_literal: true

module Primer
  class AvatarComponent < Primer::Component
    SIZE_MAPPINGS = {
      1 => "avatar-1",
      2 => "avatar-2",
      3 => "avatar-3",
      4 => "avatar-4",
      5 => "avatar-5",
      6 => "avatar-6",
      7 => "avatar-7",
      8 => "avatar-8",
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    def initialize(src:, alt:, size: nil, **kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :img
      @kwargs[:src] = src
      @kwargs[:alt] = alt
      @kwargs[:classes] = class_names(
        "avatar",
        kwargs[:classes],
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size.to_i)]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
