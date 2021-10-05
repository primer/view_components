# frozen_string_literal: true

require "linter_test_case"

class SubheadComponentMigrationCounterTest < LinterTestCase
  include Primer::BasicLinterSharedTests

  private

  def linter_class
    ERBLint::Linters::SubheadComponentMigrationCounter
  end

  def default_tag
    "div"
  end

  def default_class
    "Subhead"
  end
end
