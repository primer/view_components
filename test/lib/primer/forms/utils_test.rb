# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::UtilsTest < Minitest::Test
  # This should pass under both Rubies that have the bug fix described in
  # https://github.com/ruby/ruby/pull/5646 and Rubies that do not. Ruby versions 2.7 to 3.1
  # (inclusive) are affected. See also https://bugs.ruby-lang.org/issues/18624.
  def test_const_source_location
    ensure_autoload!

    actual_loc = Primer::Forms::Utils.const_source_location("Primer::Forms::ConstSrc")
    expected_loc = File.join(File.dirname(__FILE__), "const_src.rb")

    assert actual_loc == expected_loc
  end

  def test_const_source_location_falls_back_to_enumerating_load_path
    # Normally this would be dangerous since test/lib isn't Zeitwerk-friendly, but because
    # we're doing it after Zeitwerk setup, it will essentially have no effect.
    Rails.autoloaders.main.push_dir(Rails.root.join("..", "test", "lib"))
    ensure_autoload!

    called = false

    Object.stub(:const_source_location, [false, 0]) do
      actual_loc = Primer::Forms::Utils.const_source_location("Primer::Forms::ConstSrc")
      expected_loc = File.join(File.dirname(__FILE__), "const_src.rb")
      assert actual_loc == expected_loc
      called = true
    end

    assert called, "Object.const_source_location was not called"
  end

  private

  def ensure_autoload!
    # Load the constant so const_source_location will return the correct path instead of
    # the path to the file that defines the autoload (which is this file, see below).
    Primer::Forms.const_get(:ConstSrc)
  rescue NameError
    # We unfortunately can't add test/lib to the load path because it's not Zeitwerk-friendly,
    # so we fake it by setting up the autoload to our test file manually.
    Primer::Forms.autoload :ConstSrc, File.join(File.dirname(__FILE__), "const_src")
    Primer::Forms.const_get(:ConstSrc)
  end
end
