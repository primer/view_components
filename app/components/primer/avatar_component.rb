# frozen_string_literal: true

module Primer
  class AvatarComponent < Primer::Component
    SMALL_THRESHOLD = 24

    def initialize(src:, alt:, size: 20, square: false, **kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :img
      @kwargs[:src] = src
      @kwargs[:alt] = alt
      @kwargs[:size] = size
      @kwargs[:height] = size
      @kwargs[:width] = size

      @kwargs[:classes] = class_names(
        "avatar",
        "avatar--small" => size < SMALL_THRESHOLD,
        "CircleBadge" => !square,
        kwargs[:classes],
      )
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
