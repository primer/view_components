# frozen_string_literal: true

module Primer
  module Alpha
    # A wrapper for CSS's flexbox layout mechanism that provides a more accessible API
    # and built-in responsiveness.
    class Stack < Primer::Component
      DEFAULT_TAG = :div

      # Base class for responsive Stack arguments. Used internally.
      class ResponsiveArg
        # The primer/react Stack component defines three breakpoints, but PVC uses five.
        # We define this array as an index-based mapping between the two systems. The first
        # element is the default and results in eg. { "justify" => "start" }, while the
        # other breakpoints result in keys with breakpoint suffixes, eg.
        # { "justify-narrow" => "start" }.
        BREAKPOINTS = [nil, :narrow, :regular, :wide, :wide]

        include FetchOrFallbackHelper

        class << self
          def for(values)
            cache[[values, arg_name].hash] ||= new(values)
          end

          private

          def cache
            Thread.current[:pvc_stack_cache] ||= {}
          end
        end

        def arg_name
          raise NotImplementedError, "Subclasses must implement the `#{__method__}' method"
        end

        def to_data_attributes
          @data_attributes ||= data_attributes_for(self.class.arg_name, values)
        end

        private

        def data_attributes_for(property, values)
          values.take(BREAKPOINTS.size).each_with_object({}).with_index do |(value, memo), i|
            next unless value
            property_with_breakpoint = [property, BREAKPOINTS[i]].compact.join("-")
            memo[property_with_breakpoint] = value
          end
        end

        def fetch_or_fallback_all(allowed_values, given_values, default_value)
          Array(given_values).map do |given_value|
            fetch_or_fallback(allowed_values, given_value, default_value)
          end
        end

        def values
          raise NotImplementedError, "Subclasses must implement the `#{__method__}' method"
        end
      end

      # Stack's justify argument. Used internally.
      class JustifyArg < ResponsiveArg
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
      class DirectionArg < ResponsiveArg
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
      class AlignArg < ResponsiveArg
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
      class WrapArg < ResponsiveArg
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
      class PaddingArg < ResponsiveArg
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
      class GapArg < ResponsiveArg
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
