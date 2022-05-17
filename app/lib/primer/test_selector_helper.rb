# frozen_string_literal: true

module Primer
  # Module to allow components to deal with the `test_selector` argument.
  # It will only add the selector if env is not Production.
  #
  # test_selector: "foo" => data-test-selector="foo"
  module TestSelectorHelper
    TEST_SELECTOR_TAG = :test_selector

    def add_test_selector(args)
      if args.key?(TEST_SELECTOR_TAG) && !Rails.env.production?
        args[:data] ||= {}
        args[:data][TEST_SELECTOR_TAG] = args[TEST_SELECTOR_TAG]
      end

      args.except(TEST_SELECTOR_TAG)
    end
  end
end
