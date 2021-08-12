# frozen_string_literal: true

module Primer
  module AssertAllocationsHelper
    def assert_allocations(count)
      GC.disable
      total_start = GC.stat[:total_allocated_objects]
      yield
      total_end = GC.stat[:total_allocated_objects]
      GC.enable

      total = total_end - total_start

      assert_equal count, total, "Expected between #{count} allocations, got #{total} allocations."
    end
  end
end
