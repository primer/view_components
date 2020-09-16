# frozen_string_literal: true

module Primer
  class StateComponent < Primer::Component
    # Component for rendering the status of an item
    #
    # title(string): (required) title attribute
    # color(symbol): label background color
    # size(symbol): label size
    # counter(integer): counter value
    # **args(hash): utility parameters for Primer::Classify
    COLOR_DEFAULT = :default
    COLOR_MAPPINGS = {
      COLOR_DEFAULT => "",
      :green => "State--green",
      :red => "State--red",
      :purple => "State--purple",
    }.freeze
    COLOR_OPTIONS = COLOR_MAPPINGS.keys

    SIZE_DEFAULT = :default
    SIZE_MAPPINGS = {
      SIZE_DEFAULT => "",
      :small => "State--small",
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    TAG_DEFAULT = :span
    TAG_OPTIONS = [TAG_DEFAULT, :div, :a]

    def initialize(
      title:,
      color: COLOR_DEFAULT,
      tag: TAG_DEFAULT,
      size: SIZE_DEFAULT,
      **kwargs
    )
      @kwargs = kwargs
      @kwargs[:title] = title
      @kwargs[:tag] = fetch_or_fallback(TAG_OPTIONS, tag.to_sym, TAG_DEFAULT)
      @kwargs[:classes] = class_names(
        @kwargs[:classes],
        "State",
        COLOR_MAPPINGS[fetch_or_fallback(COLOR_OPTIONS, color.to_sym, COLOR_DEFAULT)],
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size.to_sym, SIZE_DEFAULT)]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
