# frozen_string_literal: true

module Primer
  module AssertAllocationsHelper
    def assert_allocations(range_or_count)
      range = case range_or_count
              when Integer
                range_or_count..range_or_count
              else
                range_or_count
              end

      GC.disable
      total_start = GC.stat[:total_allocated_objects]
      yield
      total_end = GC.stat[:total_allocated_objects]
      GC.enable

      total = total_end - total_start

      msg = if range.size > 1
              "Expected between #{range.first} and #{range.last} allocations, got #{total} allocations"
            else
              "Expected #{range.first} allocations, got #{total} allocations"
            end

      assert_includes range, total, msg
    end

    def expectations_for(type)
      self.class::EXPECTATIONS[ruby_version][type]
    end

    def ruby_version
      return @ruby_version if defined? @ruby_version

      @ruby_version = ENV["RUBY_VERSION"].dup
      @ruby_version.gsub!("ruby-", "")
      @ruby_version[-1] = "x"
      @ruby_version
    end
  end
end
