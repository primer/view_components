# frozen_string_literal: true

require "linter_test_case"

class CloseButtonComponentMigrationCounterTest < LinterTestCase
  include Primer::BasicLinterSharedTests

  def linter_class
    ERBLint::Linters::CloseButtonComponentMigrationCounter
  end

  def default_tag
    "button"
  end

  def default_class
    "close-button"
  end
end
