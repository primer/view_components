# frozen_string_literal: true

require "lib/test_helper"

class Primer::StaticTest < Minitest::Test
  def test_generate_statuses
    statuses = Primer::Static.generate_statuses

    assert_equal Hash, statuses.class
    assert_equal String, statuses.values.first.class
  end

  def test_writing_and_reading_statuses
    Primer::Static.dump(:statuses)

    assert_equal JSON.pretty_generate(Primer::Static.generate_statuses), Primer::Static.read(:statuses).chomp
  end

  def test_writing_and_reading_constants
    Primer::Static.dump(:constants)

    assert_equal JSON.pretty_generate(Primer::Static.generate_constants), Primer::Static.read(:constants).chomp
  end

  def test_writing_and_reading_audited_at
    Primer::Static.dump(:audited_at)

    assert_equal JSON.pretty_generate(Primer::Static.generate_audited_at), Primer::Static.read(:audited_at).chomp
  end

  def test_writing_and_reading_arguments
    Primer::Static.dump(:arguments)

    assert_equal JSON.pretty_generate(Primer::Static.generate_arguments), Primer::Static.read(:arguments).chomp
  end

  def test_writing_and_reading_previews
    Primer::Static.dump(:previews)

    assert_equal JSON.pretty_generate(Primer::Static.generate_previews), Primer::Static.read(:previews).chomp
  end

  def test_writing_and_reading_info_arch
    Primer::Static.dump(:info_arch)

    assert_equal JSON.pretty_generate(Primer::Static.generate_info_arch), Primer::Static.read(:info_arch).chomp
  end
end
