# frozen_string_literal: true

require "linter_test_case"

class BreadcrumbsComponentMigrationCounterTest < LinterTestCase
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
