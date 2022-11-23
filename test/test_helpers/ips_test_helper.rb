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

    def assert_more_ips(faster, slower, msg = nil)
      assert faster.data.first[:ips] > slower.data.first[:ips], msg
    end

    private

    def suppress_output
      original_stderr = $stderr.clone
      original_stdout = $stdout.clone
      $stderr.reopen(File.new("/dev/null", "w"))
      $stdout.reopen(File.new("/dev/null", "w"))
      yield
    ensure
      $stdout.reopen(original_stdout)
      $stderr.reopen(original_stderr)
    end
  end
end
