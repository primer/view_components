# frozen_string_literal: true

require "primer/classify"

# See: https://github.com/rails/rails/pull/46666
ActionView::Helpers::Tags::Base.prepend(
  Module.new do
    def initialize(*args, **kwargs, &block)
      super

      return if defined?(@generate_error_markup)

      @generate_error_markup = @options.delete(:generate_error_markup) { true }
    end

    private

    def error_wrapping(html_tag)
      return html_tag unless @generate_error_markup

      # :nocov:
      super
      # :nocov:
    end
  end
)

module Primer
  module Forms
    # :nodoc:
    class Builder < ActionView::Helpers::FormBuilder
      include Primer::ClassNameHelper

      UTILITY_KEYS = Primer::Classify::Utilities::UTILITIES.keys.freeze

      def label(method, text = nil, **options, &block)
        super(method, text, classify(options).merge(generate_error_markup: false), &block)
      end

      def check_box(method, options = {}, checked_value = 1, unchecked_value = 0, &block)
        super(
          method,
          classify(options).merge(generate_error_markup: false),
          checked_value,
          unchecked_value,
          &block
        )
      end

      def radio_button(*args, **options, &block)
        super(*args, classify(options).merge(generate_error_markup: false), &block)
      end

      def select(method, choices = nil, options = {}, html_options = {}, &block)
        super(method, choices, options.merge(generate_error_markup: false), classify(html_options), &block)
      end

      def text_field(*args, **options, &block)
        super(*args, classify(options).merge(generate_error_markup: false), &block)
      end

      def text_area(*args, **options, &block)
        super(*args, classify(options).merge(generate_error_markup: false), &block)
      end

      private

      # This method does the following:
      #
      # 1. Runs Primer's classify routine to convert entries like mb: 1 to mb-1.
      # 2. Runs classify on both options[:class] and options[:classes]. The first
      #    is expected by Rails/HTML while the second is specific to Primer.
      # 3. Combines options[:class] and options[:classes] into options[:class]
      #    so the options hash can be easily passed to Rails form builder methods.
      #
      def classify(options)
        options[:classes] = class_names(options.delete(:class), options[:classes])
        options.merge!(Primer::Classify.call(options))
        options.except!(*UTILITY_KEYS)
        options[:class] = class_names(options[:class], options.delete(:classes))
        options
      end
    end
  end
end
