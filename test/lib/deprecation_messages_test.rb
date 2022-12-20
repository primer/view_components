# frozen_string_literal: true

require "lib/test_helper"
require_relative "../../lib/primer/view_components/statuses"

Dir["app/components/**/*.rb"].each { |file| require_relative "../../#{file}" }

# Scenarios:
#
# The first scenario is to test a component that is not deprecated. Beyond that,
# here is a table of possible configurations that need to be tested. Scenarios
# that are marked as not needing a test are invalid configurations. These are
# prevented through tests in 'deprecations_test.rb'
#
# For information on what configurations are valid / invalid, please see the
# documentation in 'docs/contributors/deprecations.md'

class DeprecationMessagesTest < Minitest::Test
  def setup
    @component = "Example::DoStuffComponent"
    @replacement = "Example::Beta::DoStuff"
    @guide = "https://example.com/guide"
  end

  def test_not_deprecated
    assert_nil Primer::Deprecations.deprecation_message("NonExistent::Component")
  end

  def test_replacement_correctable_guide
    msg = deprecation_message({
                                replacement: @replacement,
                                autocorrect: true,
                                guide: @guide
                              })

    assert_equal "'#{@component}' has been deprecated. Please update your code to use '#{@replacement}'. Use Rubocop's auto-correct, or replace it yourself. See #{@guide} for more information.", msg
  end

  def test_replacement_correctable_no_guide
    msg = deprecation_message({
                                replacement: @replacement,
                                autocorrect: true
                              })

    assert_equal "'#{@component}' has been deprecated. Please update your code to use '#{@replacement}'. Use Rubocop's auto-correct, or replace it yourself.", msg
  end

  def test_replacement_not_correctable_guide
    msg = deprecation_message({
                                replacement: @replacement,
                                guide: @guide
                              })

    assert_equal "'#{@component}' has been deprecated. Please update your code to use '#{@replacement}'. See #{@guide} for more information.", msg
  end

  def test_no_replacement_not_correctable_guide
    msg = deprecation_message({
                                guide: @guide
                              })

    assert_equal "'#{@component}' has been deprecated. Unfortunately, there is no direct replacement. See #{@guide} for more information and available options.", msg
  end

  private

  def deprecation_message(options)
    Primer::Deprecations.register_deprecation(@component, options)
    Primer::Deprecations.deprecation_message(@component)
  end
end
