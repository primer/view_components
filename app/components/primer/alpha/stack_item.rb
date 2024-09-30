# frozen_string_literal: true

module Primer
  module Alpha
    # TODO: docs this
    class StackItem < Primer::Component
      DEFAULT_TAG = :div

      def initialize(tag: DEFAULT_TAG, grow: false, **system_arguments)
        @tag = tag
        @grow = grow
        @system_arguments = system_arguments
        @system_arguments[:tag] = tag

        @system_arguments[:classes] = class_names(
          @system_arguments.delete(:classes),
          "StackItem"
        )

        @system_arguments[:data] = merge_data(
          @system_arguments, {
            data: { grow: grow }
          }
        )
      end
    end
  end
end
