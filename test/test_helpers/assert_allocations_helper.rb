# frozen_string_literal: true

# This code is exercised by rake bench
# :nocov:

module Primer
  module AssertAllocationsHelper
    def assert_allocations(count_map)
      yield
      GC.disable
      total_start = GC.stat[:total_allocated_objects]
      yield
      total_end = GC.stat[:total_allocated_objects]
      GC.enable

      total = total_end - total_start
      count = count_map[ruby_version]

      assert_equal count, total, "Expected #{count} allocations, got #{total} allocations"
    end

    private

    def ruby_version
      @ruby_version ||= RUBY_VERSION.split(".").take(2).join(".")
    end
  end
end
