# frozen_string_literal: true

module Primer
  module Alpha
    # Stack is a layout component that creates responsive horizontal and vertical flows.
    class Stack < Primer::Component
      DEFAULT_TAG = :div

      # Stack's justify argument. Used internally.
      class JustifyArg < Primer::ResponsiveArg
        attr_reader :values
        DEFAULT = :start
        MAPPING = {
          DEFAULT => "start",
          :center => "center",
          :end => "end",
          :space_between => "space-between",
          :space_evenly => "space-evenly"
        }.freeze
        OPTIONS = MAPPING.keys.freeze

        def initialize(values)
          @values = fetch_or_fallback_all(OPTIONS, values, DEFAULT).map do |value|
            MAPPING[value]
          end
        end

        def self.arg_name
          :justify
        end
      end

      # Stack's direction argument. Used internally.
      class DirectionArg < Primer::ResponsiveArg
        attr_reader :values
        DEFAULT = :vertical
        OPTIONS = [
          DEFAULT,
          :horizontal
        ].freeze

        def initialize(values)
          @values = fetch_or_fallback_all(OPTIONS, values, DEFAULT)
        end

        def self.arg_name
          :direction
        end
      end

      # Stack's align argument. Used internally.
      class AlignArg < Primer::ResponsiveArg
        attr_reader :values
        DEFAULT = :stretch
        OPTIONS = [
          DEFAULT,
          :start,
          :center,
          :end,
          :baseline
        ].freeze

        def initialize(values)
          @values = fetch_or_fallback_all(OPTIONS, values, DEFAULT)
        end

        def self.arg_name
          :align
        end
      end

      # Stack's wrap argument. Used internally.
      class WrapArg < Primer::ResponsiveArg
        attr_reader :values
        DEFAULT = :nowrap
        OPTIONS = [
          DEFAULT,
          :wrap
        ].freeze

        def initialize(values)
          @values = fetch_or_fallback_all(OPTIONS, values, DEFAULT)
        end

        def self.arg_name
          :wrap
        end
      end

      # Stack's padding argument. Used internally.
      class PaddingArg < Primer::ResponsiveArg
        attr_reader :values
        DEFAULT = :none
        OPTIONS = [
          DEFAULT,
          :condensed,
          :normal,
          :spacious
        ].freeze

        def initialize(values)
          @values = fetch_or_fallback_all(OPTIONS, values, DEFAULT)
        end

        def self.arg_name
          :padding
        end
      end

      # Stack's gap argument. Used internally.
      class GapArg < Primer::ResponsiveArg
        attr_reader :values
        DEFAULT = nil
        OPTIONS = [
          DEFAULT,
          :condensed,
          :normal,
          :spacious
        ].freeze

        def initialize(values)
          @values = fetch_or_fallback_all(OPTIONS, values, DEFAULT)
        end

        def self.arg_name
          :gap
        end
      end

      ARG_CLASSES = [
        JustifyArg,
        DirectionArg,
        AlignArg,
        WrapArg,
        PaddingArg,
        GapArg
      ].freeze


      # @param tag [Symbol] Customize the element type of the rendered container.
      # @param gap [Symbol] Specify the gap between children elements in the stack. <%= one_of(Primer::Alpha::Stack::GapArg::OPTIONS) %>
      # @param direction [Symbol] Specify the direction for the stack container. <%= one_of(Primer::Alpha::Stack::DirectionArg::OPTIONS) %>
      # @param align [Symbol] Specify the alignment between items in the cross-axis of the direction. <%= one_of(Primer::Alpha::Stack::AlignArg::OPTIONS) %>
      # @param wrap [Symbol] Specify whether items are forced onto one line or can wrap onto multiple lines. <%= one_of(Primer::Alpha::Stack::WrapArg::OPTIONS) %>
      # @param justify [Symbol] Specify how items will be distributed in the stacking direction. <%= one_of(Primer::Alpha::Stack::JustifyArg::OPTIONS) %>
      # @param padding [Symbol] Specify the padding of the stack container. <%= one_of(Primer::Alpha::Stack::PaddingArg::OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        tag: DEFAULT_TAG,
        justify: JustifyArg::DEFAULT,
        gap: GapArg::DEFAULT,
        direction: DirectionArg::DEFAULT,
        align: AlignArg::DEFAULT,
        wrap: WrapArg::DEFAULT,
        padding: PaddingArg::DEFAULT,
        **system_arguments
      )
        @system_arguments = system_arguments

        @system_arguments[:tag] = tag
        @system_arguments[:classes] = class_names(
          @system_arguments.delete(:classes),
          "Stack"
        )

        @system_arguments[:data] = merge_data(
          @system_arguments, {
            data: {
              **JustifyArg.for(justify).to_data_attributes,
              **GapArg.for(gap).to_data_attributes,
              **DirectionArg.for(direction).to_data_attributes,
              **AlignArg.for(align).to_data_attributes,
              **WrapArg.for(wrap).to_data_attributes,
              **PaddingArg.for(padding).to_data_attributes,
            }
          }
        )
      end
    end
  end
end
