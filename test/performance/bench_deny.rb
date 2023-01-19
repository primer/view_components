# frozen_string_literal: true

require "minitest"
require "minitest/benchmark"
require "test_helper"
require "test_helpers/ips_test_helper"

class BenchDeny < Minitest::Benchmark
  include Primer::IPSTestHelper

  def bench_deny_single_argument
    non_prod_results = measure_ips { Primer::DenyComponent.new }

    # rubocop:disable Rails/Inquiry
    prod_results = Rails.stub(:env, "production".inquiry) do
      measure_ips { Primer::DenyComponent.new }
    end
    # rubocop:enable Rails/Inquiry

    assert_more_ips(
      prod_results, non_prod_results,
      "Primer::Component#deny_single_argument is supposed to be more performant in production"
    )
  end
end
