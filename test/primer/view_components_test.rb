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
    Primer::ViewComponents.dump(:statuses)

    assert_equal JSON.pretty_generate(Primer::ViewComponents.generate_statuses), Primer::ViewComponents.read(:statuses).chomp
  end

  def test_writing_and_reading_constants
    # we make sure that we can dump to disk and then read back again
    Primer::ViewComponents.dump(:constants)

    assert_equal JSON.pretty_generate(Primer::ViewComponents.generate_constants), Primer::ViewComponents.read(:constants).chomp
  end
end
