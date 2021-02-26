# frozen_string_literal: true

require "test_helper"

class Primer::ViewComponentsTest < Minitest::Test
  def test_generate_statuses
    statuses = Primer::ViewComponents.generate_statuses

    assert_equal Hash, statuses.class
    assert_equal String, statuses.values.first.class
  end

  def test_writing_and_reading_statuses
    # we make sure that we can dump to disk and then read back again
    Primer::ViewComponents.dump_statuses

    assert_equal Primer::ViewComponents.generate_statuses.to_json, Primer::ViewComponents.read_statuses.chomp
  end
end
