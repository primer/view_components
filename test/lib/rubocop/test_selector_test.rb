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

  def test_primer_component_with_symbol_key
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(data: { "test-selector": "the-component" })
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer/TestSelector: Prefer the `test_selector` argument over manually generating a `data-test-selector` attribute: https://primer.style/view-components/system-arguments.\n", cop.offenses.first.message
  end

  def test_primer_component_with_string_key
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(data: { "test-selector" => "the-component" })
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer/TestSelector: Prefer the `test_selector` argument over manually generating a `data-test-selector` attribute: https://primer.style/view-components/system-arguments.\n", cop.offenses.first.message
  end

  def test_non_primer_view_helper
    investigate(cop, <<-RUBY)
      octicon(data: { "test-selector": "the-octicon" })
    RUBY

    assert_empty cop.offenses
  end

  def test_primer_view_helper
    investigate(cop, <<-RUBY)
      primer_octicon(data: { "test-selector": "the-octicon" })
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer/TestSelector: Prefer the `test_selector` argument over manually generating a `data-test-selector` attribute: https://primer.style/view-components/system-arguments.\n", cop.offenses.first.message
  end

  def test_no_test_selector
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new
    RUBY

    assert_empty cop.offenses
  end

  def test_data_with_no_test_selector
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(data: { "some-other" => "data-thing" })
    RUBY

    assert_empty cop.offenses
  end
end
