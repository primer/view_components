# frozen_string_literal: true

module Primer
  class OcticonComponent < Primer::Component
    include Primer::ClassNameHelper
    include OcticonsHelper

    SIZE_DEFAULT = :small
    SIZE_MAPPINGS = {
      SIZE_DEFAULT => 16,
      :medium => 32,
      :large => 64,
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    def initialize(icon:, size: SIZE_DEFAULT, **kwargs)
      @icon, @kwargs = icon, kwargs

      @kwargs[:height] = SIZE_MAPPINGS[size]
      @kwargs[:class] = class_names(@kwargs[:class], Primer::Classify.call(**@kwargs)[:class])
    end

    def call
      octicon(@icon, **@kwargs)
    end
  end
end
