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
      classes = class_names(@kwargs.delete(:class), @kwargs.delete(:classes))
      @kwargs[:class] = class_names(Primer::Classify.call(**@kwargs)[:class], classes)
      @kwargs = @kwargs.except(*Primer::Classify::VALID_KEYS)
      @kwargs[:height] = SIZE_MAPPINGS[size]
    end

    def call
      octicon(@icon, **@kwargs)
    end
  end
end
