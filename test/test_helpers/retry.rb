# frozen_string_literal: true

# :nocov:

# based on https://github.com/y-yagi/minitest-retry/blob/master/lib/minitest/retry.rb
module Minitest
  module Retry
    RETRY_MAX = 3
    ERRORS = Primer::DriverTestHelpers.chrome? ? [Ferrum::TimeoutError] : []
    ERRORS.freeze

    module PrependedClassMethods
      def run_one_method(klass, method_name)
        result = super

        return result if !should_retry?(klass, result.failures) || result.skipped?

        Minitest::Retry::RETRY_MAX.times do |count|
          puts "Retrying '#{method_name}' #{count + 1} of #{Minitest::Retry::RETRY_MAX}. Error: #{result.failures.map(&:message).join(',')}"

          result = super(klass, method_name)
          break if result.failures.empty?
        end

        result
      end

      def should_retry?(klass, failures)
        return false if failures.empty?

        errors = failures.map { |failure| failure.error.class }
        test_case_errors_to_retry = klass.respond_to?(:errors_to_retry) ? klass.errors_to_retry : []
        (errors & [*Minitest::Retry::ERRORS, *test_case_errors_to_retry]).any?
      end
    end

    def self.included(base)
      class << base
        prepend PrependedClassMethods
      end
    end
  end
end

Minitest.include(Minitest::Retry)
