# frozen_string_literal: true

require "linter_test_case"

class BlankslateComponentMigrationCounterTest < LinterTestCase
  include Primer::BasicLinterSharedTests

  private

  def linter_class
    ERBLint::Linters::BlankslateComponentMigrationCounter
  end

  def default_tag
    "div"
  end

  def default_class
    "blankslate"
  end
end
