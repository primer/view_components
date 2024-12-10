# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::UtilsTest < Minitest::Test
  # This should pass under both Rubies that have the bug fix described in
  # https://github.com/ruby/ruby/pull/5646 and Rubies that do not. Ruby versions 2.7 to 3.1
  # (inclusive) are affected. See also https://bugs.ruby-lang.org/issues/18624.
  def test_const_source_location
    # Load the constant so const_source_location will return the correct path instead of
    # the path to the internal Zeitwerk file that defines the autoload.
    Primer::Forms.const_get(:ConstSrc)

    actual_loc = Primer::Forms::Utils.const_source_location("Primer::Forms::ConstSrc")
    expected_loc = File.join(File.dirname(__FILE__), "const_src.rb")

    assert actual_loc == expected_loc
  end

  def test_const_source_location_falls_back_to_enumerating_load_path
    called = false

    Object.stub(:const_source_location, [false, 0]) do
      actual_loc = Primer::Forms::Utils.const_source_location("Primer::Forms::ConstSrc")
      expected_loc = File.join(File.dirname(__FILE__), "const_src.rb")
      assert actual_loc == expected_loc
      called = true
    end

    assert called, "Object.const_source_location was not called"
  end
end
