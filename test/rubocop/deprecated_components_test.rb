# frozen_string_literal: true

require "cop_test"

class RubocopDeprecatedComponentsTest < CopTest
  def cop_class
    RuboCop::Cop::Primer::DeprecatedComponents
  end

  def test_raises_offense_if_calling_legacy_component
    investigate(cop, <<-RUBY)
      Primer::Tooltip.new
      Primer::BlankslateComponent.new
      Primer::FlexComponent.new
    RUBY

    assert_equal 3, cop.offenses.count
  end

  def test_raises_offense_if_calling_legacy_component_with_args
    investigate(cop, <<-RUBY)
      Primer::FlexComponent.new(:foo)
    RUBY
    assert_equal 1, cop.offenses.count
  end

  def test_raises_offense_if_calling_legacy_component_in_render
    investigate(cop, <<-RUBY)
      render(Primer::Tooltip.new)
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_raises_offense_if_calling_legacy_component_in_render_with_args
    investigate(cop, <<-RUBY)
      render(Primer::FlexComponent.new(foo: "bar"))
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_suggests_alternative_component_if_available
    investigate(cop, <<-RUBY)
      render(Primer::Tooltip.new(foo: "bar"))
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::Tooltip has been deprecated and should not be used. Please use Primer::Alpha::Tooltip instead.", cop.offenses.first.message
  end
end
