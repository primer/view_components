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

        @system_arguments[:display] = :none if inputs.all?(&:hidden?)

        @system_arguments[:classes] = class_names(
          @system_arguments.delete(:classes),
          "FormControl-horizontalGroup" => horizontal?,
          "FormControl-spacingWrapper" => !horizontal? && inputs.size > 1
        )
      end

      def horizontal?
        @layout == HORIZONTAL
      end
    end
  end
end
