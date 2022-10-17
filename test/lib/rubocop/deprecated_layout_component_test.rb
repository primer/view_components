# frozen_string_literal: true

require "lib/cop_test_case"

class RubocopDeprecatedLayoutComponentTest < CopTestCase
  def cop_class
    RuboCop::Cop::Primer::DeprecatedLayoutComponent
  end

  def test_raises_offense_if_calling_legacy_layout_component
    investigate(cop, <<-RUBY)
      Primer::LayoutComponent.new
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_raises_offense_if_calling_legacy_layout_component_with_args
    investigate(cop, <<-RUBY)
      Primer::LayoutComponent.new
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_raises_offense_if_calling_legacy_layout_component_in_render
    investigate(cop, <<-RUBY)
      render(Primer::LayoutComponent.new)
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_raises_offense_if_calling_legacy_layout_component_in_render_with_args
    investigate(cop, <<-RUBY)
      render(Primer::LayoutComponent.new(foo: "bar"))
    RUBY

    assert_equal 1, cop.offenses.count
  end
end
