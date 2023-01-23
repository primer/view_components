# frozen_string_literal: true

require "lib/cop_test_case"

class RubocopTestSelectorTest < CopTestCase
  def cop_class
    RuboCop::Cop::Primer::TestSelector
  end

  def test_non_primer_component
    investigate(cop, <<-RUBY)
      Component.new(data: { "test-selector": "the-component" })
    RUBY

    assert_empty cop.offenses
  end

  def test_primer_component
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(data: { "test-selector": "the-component" })
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Prefer the `test_selector` argument over manually generating a `data-test-selector` attribute: https://primer.style/view-components/system-arguments.\n", cop.offenses.first.message
  end
end
