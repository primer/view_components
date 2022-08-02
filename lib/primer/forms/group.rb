# frozen_string_literal: true

require "primer/classify"

module Primer
  module Forms
    # :nodoc:
    class Group < BaseComponent
      VERTICAL = :vertical
      HORIZONTAL = :horizontal
      DEFAULT_LAYOUT = VERTICAL
      LAYOUTS = [VERTICAL, HORIZONTAL].freeze

      def initialize(inputs:, builder:, form:, layout: DEFAULT_LAYOUT, **system_arguments)
        @inputs = inputs
        @builder = builder
        @form = form
        @layout = layout
        @system_arguments = system_arguments
      end

      def horizontal?
        @layout == HORIZONTAL
      end
    end
  end
end
