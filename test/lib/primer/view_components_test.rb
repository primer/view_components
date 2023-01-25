# frozen_string_literal: true

require "lib/test_helper"

class Primer::ViewComponentsTest < Minitest::Test
  def test_generate_statuses
    statuses = Primer::ViewComponents.generate_statuses

    assert_equal Hash, statuses.class
    assert_equal String, statuses.values.first.class
  end

  def test_writing_and_reading_statuses
    Primer::ViewComponents.dump(:statuses)

    assert_equal JSON.pretty_generate(Primer::ViewComponents.generate_statuses), Primer::ViewComponents.read(:statuses).chomp
  end

  def test_writing_and_reading_constants
    Primer::ViewComponents.dump(:constants)

    assert_equal JSON.pretty_generate(Primer::ViewComponents.generate_constants), Primer::ViewComponents.read(:constants).chomp
  end

  def test_writing_and_reading_audited_at
    Primer::ViewComponents.dump(:audited_at)

    assert_equal JSON.pretty_generate(Primer::ViewComponents.generate_audited_at), Primer::ViewComponents.read(:audited_at).chomp
  end

  def test_root
    assert Primer::ViewComponents.root.join("app", "components", "primer", "base_component.rb").exist?
  end
end
