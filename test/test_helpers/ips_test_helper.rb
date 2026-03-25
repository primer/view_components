# frozen_string_literal: true

# This code is exercised by rake bench
# :nocov:

require "benchmark/ips"

module Primer
  module IPSTestHelper
    def measure_ips(&block)
      suppress_output do
        Benchmark.ips { |x| x.report(&block) }
      end
    end

    # Allow a tolerance factor to account for CI noise and Rails.stub overhead.
    # A tolerance of 0.9 means `faster` can be up to 10% slower in absolute
    # terms and still pass, which prevents flaky failures on noisy CI runners.
    def assert_more_ips(faster, slower, msg = nil, tolerance: 0.9)
      assert faster.data.first[:ips] > slower.data.first[:ips] * tolerance, msg
    end

    private

    def suppress_output
      original_stderr = $stderr.clone
      original_stdout = $stdout.clone
      $stderr.reopen(File.new("File::NULL", "w"))
      $stdout.reopen(File.new("File::NULL", "w"))
      yield
    ensure
      $stdout.reopen(original_stdout)
      $stderr.reopen(original_stderr)
    end
  end
end
