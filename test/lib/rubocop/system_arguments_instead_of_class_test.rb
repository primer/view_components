# frozen_string_literal: true

require "lib/cop_test_case"

class RubocopSystemArgumentInsteadOfClassTest < CopTestCase
  def cop_class
    RuboCop::Cop::Primer::SystemArgumentInsteadOfClass
  end

  def test_non_primer_component
    investigate(cop, <<-RUBY)
      Component.new(classes: "mr-1")
    RUBY

    assert_empty cop.offenses
  end

  def test_primer_component
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(classes: "mr-1")
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer/SystemArgumentInsteadOfClass: Avoid using CSS classes when you can use System Arguments: https://primer.style/view-components/system-arguments.\n", cop.offenses.first.message
  end

  def test_non_primer_view_helper
    investigate(cop, <<-RUBY)
      octicon(classes: "mr-1")
    RUBY

    assert_empty cop.offenses
  end

  def test_primer_view_helper
    investigate(cop, <<-RUBY)
      primer_octicon(classes: "mr-1")
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer/SystemArgumentInsteadOfClass: Avoid using CSS classes when you can use System Arguments: https://primer.style/view-components/system-arguments.\n", cop.offenses.first.message
  end

  def test_custom_class
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(classes: "mr-1 custom")
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer/SystemArgumentInsteadOfClass: Avoid using CSS classes when you can use System Arguments: https://primer.style/view-components/system-arguments.\n", cop.offenses.first.message
  end

  def test_marketing_class
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(classes: "f4-mktg")
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer/SystemArgumentInsteadOfClass: Avoid using CSS classes when you can use System Arguments: https://primer.style/view-components/system-arguments.\n", cop.offenses.first.message
  end

  def test_no_classes
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new
    RUBY

    assert_empty cop.offenses
  end
end
