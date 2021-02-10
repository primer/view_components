# frozen_string_literal: true

require "test_helper"

class Primer::ViewComponentsTest < Minitest::Test
  def test_generate_statuses
    statuses = Primer::ViewComponents.generate_statuses

    assert_equal Hash, statuses.class
    assert_equal String, statuses.values.first.class
  end

  def test_written_statuses_are_up_to_date
    statuses = Primer::ViewComponents.generate_statuses

    begin
      read_statuses = Primer::ViewComponents.read_statuses
    rescue Errno::ENOENT
      assert false, "Hi! statuses.json is missing. Please run `bundle exec rake statuses:dump` and commit the diff"
    end

    # we make sure any changes to statuses are committed to the static file
    assert_equal statuses, JSON.parse(read_statuses), "Hi! statuses.json is out of date. Please run `bundle exec rake statuses:dump` and commit the diff"

    # Now that we know we're up to date, we make sure that we can
    # dump to disk and then read back again
    Primer::ViewComponents.dump_statuses

    assert_equal Primer::ViewComponents.generate_statuses.to_json, Primer::ViewComponents.read_statuses.chomp
  end
end
