# frozen_string_literal: true

module Primer
  class Classify
    # :nodoc:
    class Cache
      delegate :empty?, :size, :length, to: :@lookup

      include Singleton

      def initialize
        @cache_enabled = true
        @max_size = Rails.application.config.primer_view_components.max_classify_cache_size
        @lookup = {}
      end

      private :initialize

      def max_size=(max_size)
        @max_size = max_size
        @lookup.shift while @lookup.size > @max_size
      end

      def disable
        @cache_enabled = false
        yield
        @cache_enabled = true
      end

      def clear!
        @lookup.clear
      end

      def fetch(*args)
        unless @cache_enabled
          result = yield if block_given?
          return result
        end

        key = args.hash
        found = true
        value = @lookup.delete(key) { found = false }

        if found
          @lookup[key] = value
        else
          return unless block_given?

          @lookup[key] = yield.tap do |val|
            @lookup.shift if @lookup.length > @max_size
          end
        end
      end
    end
  end
end
