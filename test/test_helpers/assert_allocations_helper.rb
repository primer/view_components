# frozen_string_literal: true

# This code is exercised by rake bench
# :nocov:

require "allocation_stats"

module Primer
  module AssertAllocationsHelper
    def assert_allocations(count_map, &block)
      trace = AllocationStats.trace(&block)
      total = trace.allocations.all.size
      count = count_map[ruby_version]

      if count.nil?
        raise "No allocation count mapped for Ruby version #{ruby_version}. " \
              "Available versions: #{count_map.keys.sort.join(', ')}. " \
              "Actual allocations: #{total}"
      end

      assert_equal count, total, "Expected #{count} allocations, got #{total} allocations"
    end

    private

    def ruby_version
      @ruby_version ||= RUBY_VERSION.split(".").take(2).join(".")
    end
  end
end
