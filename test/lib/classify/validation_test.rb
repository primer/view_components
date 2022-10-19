# frozen_string_literal: true

require "lib/test_helper"

class PrimerClassifyValidationTest < Minitest::Test
  def test_invalid?
    assert_invalid("d-block")
    assert_invalid("color-fg-default")
    assert_valid("custom-class")
  end

  private

  def assert_invalid(class_name)
    assert(Primer::Classify::Validation.invalid?(class_name))
  end

  def assert_valid(class_name)
    refute(Primer::Classify::Validation.invalid?(class_name))
  end
end
