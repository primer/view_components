# frozen_string_literal: true

require "primer/classify"

module Primer
  module Forms
    # :nodoc:
    class Builder < ActionView::Helpers::FormBuilder
      include Primer::ClassNameHelper

      UTILITY_KEYS = Primer::Classify::Utilities::UTILITIES.keys.freeze

      def label(*args, **options, &block)
        super(*args, classify(options), &block)
      end

      def check_box(method, options = {}, checked_value = 1, unchecked_value = 0, &block)
        super(method, classify(options), checked_value, unchecked_value, &block)
      end

      def radio_button(*args, **options, &block)
        super(*args, classify(options), &block)
      end

      def select(*args, **options, &block)
        super(*args, classify(options), &block)
      end

      def text_field(*args, **options, &block)
        super(*args, classify(options), &block)
      end

      def text_area(*args, **options, &block)
        super(*args, classify(options), &block)
      end

      private

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
