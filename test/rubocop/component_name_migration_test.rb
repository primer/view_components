# frozen_string_literal: true

require "cop_test"

class RubocopComponentNameMigrationTest < CopTest
  def cop_class
    RuboCop::Cop::Primer::ComponentNameMigration
  end

  def test_no_deprecated_classes
    investigate(cop, <<-RUBY)
      Primer::SomeClass.new
    RUBY

    assert_empty cop.offenses
  end

  def test_using_deprecated_class
    investigate(cop, <<-RUBY)
      Primer::TestComponent.new
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::Beta::Test.new", cop.offenses.first.corrector.rewrite.strip
  end
end
