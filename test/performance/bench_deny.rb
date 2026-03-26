# frozen_string_literal: true

require "minitest"
require "minitest/benchmark"
require "test_helper"
require "test_helpers/ips_test_helper"

class BenchDeny < Minitest::Benchmark
  include Primer::IPSTestHelper

  # Performance (latest) CI is flaky due to bleeding-edge Rails variance.
  # Tolerance 0.9 allows `faster` to be up to ~10% slower and still pass.
  TOLERANCE = ENV["RAILS_VERSION"] == "latest" ? 0.9 : 1.0

  def bench_deny_single_argument
    non_prod_results = measure_ips { Primer::DenyComponent.new }

    prod_results = Rails.stub(:env, "production".inquiry) do
      measure_ips { Primer::DenyComponent.new }
    end
    # rubocop:enable Rails/Inquiry

    assert_more_ips(
      prod_results, non_prod_results,
      "Primer::Component#deny_single_argument is supposed to be more performant in production",
      tolerance: TOLERANCE
    )
  end
end
