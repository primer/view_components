# frozen_string_literal: true

require "lib/erblint_test_case"

class SelectMenuMigrationCounterTest < ErblintTestCase
  include Primer::BasicLinterSharedTests

  private

  def linter_class
    ERBLint::Linters::SelectMenuMigrationCounter
  end

  def default_tag
    "div"
  end

  def default_class
    "SelectMenu"
  end
end
