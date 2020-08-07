# frozen_string_literal: true

require "test_helper"

class Primer::ViewComponentsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Primer::ViewComponents::VERSION::STRING
  end

  def test_autoload_defaults_to_false
    refute Primer::ViewComponents.autoload?
  end

  def test_configures_autoload_to_true
    Primer::ViewComponents.configure do |config|
      config.autoload = true
    end

    assert Primer::ViewComponents.autoload?
  ensure
    Primer::ViewComponents.reset
  end
end
