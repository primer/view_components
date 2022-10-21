# frozen_string_literal: true

require "lib/erblint_test_case"

class BreadcrumbsComponentMigrationCounterTest < ErblintTestCase
  include Primer::BasicLinterSharedTests

  private

  def linter_class
    ERBLint::Linters::BreadcrumbsComponentMigrationCounter
  end

  def default_tag
    "li"
  end

  def default_class
    "breadcrumb-item"
  end
end
