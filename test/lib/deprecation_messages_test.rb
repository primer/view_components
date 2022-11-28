# frozen_string_literal: true

require "lib/test_helper"
require_relative "../../lib/primer/view_components/statuses"

Dir["app/components/**/*.rb"].each { |file| require_relative "../../#{file}" }

class DeprecationMessagesTest < Minitest::Test
  def setup
    @deprecated_components = Primer::Deprecations.deprecated_components
  end

  def test_not_deprecated
    assert_nil Primer::Deprecations.deprecation_message("NonExistent::Component")
  end
end
