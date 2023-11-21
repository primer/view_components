# frozen_string_literal: true

# :nocov:

# based on https://github.com/y-yagi/minitest-retry/blob/master/lib/minitest/retry.rb
module Minitest
  module Retry
    RETRY_MAX = 3
    ERRORS = [
      Ferrum::TimeoutError
    ].freeze

    module ClassMethods
      def run_one_method(klass, method_name)
        result = super(klass, method_name)

        return result if !should_retry?(result.failures) || result.skipped?

        Minitest::Retry::RETRY_MAX.times do |count|
          puts "Retrying '#{method_name}' #{count + 1} of #{Minitest::Retry::RETRY_MAX}. Error: #{result.failures.map(&:message).join(',')}"

          result = super(klass, method_name)
          break if result.failures.empty?
        end

        result
      end

      def should_retry?(failures)
        return false if failures.empty?

        errors = failures.map { |failure| failure.error.class }
        (errors & Minitest::Retry::ERRORS).any?
      end
    end

    def self.prepended(base)
      class << base
        prepend ClassMethods
      end
    end
  end
end

Minitest.prepend(Minitest::Retry)
