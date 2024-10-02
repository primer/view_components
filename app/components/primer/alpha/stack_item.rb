# frozen_string_literal: true

module Primer
  module Alpha
    # StackItem is a layout component designed to be used as the child of a Stack.
    class StackItem < Primer::Component
      DEFAULT_TAG = :div

      # StackItem's grow argument. Used internally.
      class GrowArg < Primer::ResponsiveArg
        attr_reader :values
        DEFAULT = false
        OPTIONS = [
          DEFAULT,
          true
        ].freeze

        def initialize(values)
          @values = fetch_or_fallback_all(OPTIONS, values, DEFAULT)
        end

        def self.arg_name
          :grow
        end
      end

      ARG_CLASSES = [GrowArg].freeze

      # @param tag [Symbol] Customize the element type of the rendered container.
      # @param grow [Boolean] Allow item to keep size or expand to fill the available space.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
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
            data: {
              **GrowArg.for(grow).to_data_attributes
            }
          }
        )
      end
    end
  end
end
