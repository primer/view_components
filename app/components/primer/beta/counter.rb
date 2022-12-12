# frozen_string_literal: true

module Primer
  module Beta
    # Use `Counter` to add a count to navigational elements and buttons.
    #
    # @accessibility
    #   Always use `Counter` with adjacent text that provides supplementary information regarding what the count is for. For instance, `Counter`
    #   should be accompanied with text such as `issues` or `pull requests`.
    #
    class Counter < Primer::Component
      warn_on_deprecated_slot_setter
      status :beta

      DEFAULT_SCHEME = :default
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => "",
        :primary => "Counter--primary",
        :secondary => "Counter--secondary",
        # deprecated
        :gray => "Counter--primary",
        :light_gray => "Counter--secondary"
      }.freeze
      DEPRECATED_SCHEME_OPTIONS = [:gray, :light_gray].freeze
      SCHEME_OPTIONS = (SCHEME_MAPPINGS.keys - DEPRECATED_SCHEME_OPTIONS).freeze

      #
      # @example Default
      #   <%= render(Primer::Beta::Counter.new(count: 25)) %>
      #
      # @example Schemes
      #   <%= render(Primer::Beta::Counter.new(count: 25, scheme: :primary)) %>
      #   <%= render(Primer::Beta::Counter.new(count: 25, scheme: :secondary)) %>
      #
      # @param count [Integer, Float::INFINITY, nil] The number to be displayed (e.x. # of issues, pull requests)
      # @param scheme [Symbol] Color scheme. <%= one_of(Primer::Beta::Counter::SCHEME_OPTIONS) %>
      # @param limit [Integer, nil] Maximum value to display. Pass `nil` for no limit. (e.x. if `count` == 6,000 and `limit` == 5000, counter will display "5,000+")
      # @param hide_if_zero [Boolean] If true, a `hidden` attribute is added to the counter if `count` is zero.
      # @param text [String] Text to display instead of count.
      # @param round [Boolean] Whether to apply our standard rounding logic to value.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        count: 0,
        scheme: DEFAULT_SCHEME,
        limit: 5_000,
        hide_if_zero: false,
        text: "",
        round: false,
        **system_arguments
      )
        @count = count
        @limit = limit
        @hide_if_zero = hide_if_zero
        @text = text
        @round = round
        @system_arguments = deny_tag_argument(**system_arguments)

        @has_limit = !@limit.nil?
        @system_arguments[:title] = title
        @system_arguments[:tag] = :span
        @system_arguments[:classes] = class_names(
          "Counter",
          @system_arguments[:classes],
          SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME, deprecated_values: DEPRECATED_SCHEME_OPTIONS)]
        )
        @system_arguments[:hidden] = true if count == 0 && hide_if_zero # rubocop:disable Style/NumericPredicate
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { value }
      end

      private

      def title
        if @text.present?
          @text
        elsif @count.nil?
          "Not available"
        elsif @count == Float::INFINITY
          "Infinity"
        else
          count = @count.to_i
          str = number_with_delimiter(@has_limit ? [count, @limit].min : count)
          str += "+" if @has_limit && count > @limit
          str
        end
      end

      def value
        if @text.present?
          @text
        elsif @count.nil?
          "" # CSS will hide it
        elsif @count == Float::INFINITY
          "∞"
        else
          if @round
            count = @has_limit ? [@count.to_i, @limit].min : @count.to_i
            precision = count.between?(100_000, 999_999) ? 0 : 1
            units = { thousand: "k", million: "m", billion: "b" }
            str = number_to_human(count, precision: precision, significant: false, units: units, format: "%n%u")
          else
            @count = @count.to_i
            str = number_with_delimiter(@has_limit ? [@count, @limit].min : @count)
          end

          str += "+" if @has_limit && @count.to_i > @limit
          str
        end
      end
    end
  end
end
