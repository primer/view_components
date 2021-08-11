# frozen_string_literal: true

require "cop_test"

class RubocopPrimerOcticonTest < CopTest
  def cop_class
    RuboCop::Cop::Primer::PrimerOcticon
  end

  def test_primer_octicon
    investigate(cop, <<-RUBY)
      primer_octicon(:icon)
    RUBY

    assert_empty cop.offenses.map(&:message)
  end

  def test_octicon
    investigate(cop, <<-RUBY)
      octicon(:icon)
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Replace the octicon helper with primer_octicon. See https://primer.style/view-components/components/octicon for details.\n", cop.offenses.first.message
  end

  def test_octicon_with_size
    investigate(cop, <<-RUBY)
      octicon(:icon, size: 10)
      octicon(:icon, size: '10')
      octicon(:icon, size: '10px')
    RUBY

    assert_equal 3, cop.offenses.count
    cop.offenses.each do |offense|
      assert_equal "Replace the octicon helper with primer_octicon. See https://primer.style/view-components/components/octicon for details.\n", offense.message
    end
  end

  def test_octicon_with_invalid_size
    investigate(cop, <<-'RUBY')
      octicon(:icon, size: some_call)
      octicon(:icon, size: "interpolation-#{aux}")
    RUBY

    assert_empty cop.offenses
  end

  def test_octicon_with_width
    investigate(cop, <<-RUBY)
      octicon(:icon, width: 10)
      octicon(:icon, width: '10')
      octicon(:icon, width: '10px')
    RUBY

    assert_equal 3, cop.offenses.count
    cop.offenses.each do |offense|
      assert_equal "Replace the octicon helper with primer_octicon. See https://primer.style/view-components/components/octicon for details.\n", offense.message
    end
  end

  def test_octicon_with_invalid_width
    investigate(cop, <<-'RUBY')
      octicon(:icon, width: some_call)
      octicon(:icon, width: "interpolation-#{aux}")
    RUBY

    assert_empty cop.offenses
  end

  def test_octicon_with_height
    investigate(cop, <<-RUBY)
      octicon(:icon, height: 10)
      octicon(:icon, height: '10')
      octicon(:icon, height: '10px')
    RUBY

    assert_equal 3, cop.offenses.count
    cop.offenses.each do |offense|
      assert_equal "Replace the octicon helper with primer_octicon. See https://primer.style/view-components/components/octicon for details.\n", offense.message
    end
  end

  def test_octicon_with_invalid_height
    investigate(cop, <<-'RUBY')
      octicon(:icon, height: some_call)
      octicon(:icon, height: "interpolation-#{aux}")
    RUBY

    assert_empty cop.offenses
  end

  def test_octicon_with_system_arguments
    investigate(cop, <<-RUBY)
      octicon(:icon, class: "mr-1")
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Replace the octicon helper with primer_octicon. See https://primer.style/view-components/components/octicon for details.\n", cop.offenses.first.message
  end

  def test_octicon_with_custom_class
    investigate(cop, <<-RUBY)
      octicon(:icon, class: "mr-1 custom")
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Replace the octicon helper with primer_octicon. See https://primer.style/view-components/components/octicon for details.\n", cop.offenses.first.message
  end

  def test_octicon_with_class_that_cant_be_converted
    investigate(cop, <<-'RUBY')
      octicon(:icon, class: "mr-1 text-center")
    RUBY

    assert_empty cop.offenses
  end

  def test_octicon_with_class_interpolation
    investigate(cop, <<-'RUBY')
      octicon(:icon, class: "mr-1 #{aux}")
    RUBY

    assert_empty cop.offenses
  end

  def test_octicon_with_icon_string
    investigate(cop, <<-RUBY)
      octicon("icon")
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Replace the octicon helper with primer_octicon. See https://primer.style/view-components/components/octicon for details.\n", cop.offenses.first.message
  end

  def test_octicon_with_icon_block
    investigate(cop, <<-RUBY)
      octicon(some_call ? :icon : :other_icon)
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Replace the octicon helper with primer_octicon. See https://primer.style/view-components/components/octicon for details.\n", cop.offenses.first.message
  end

  def test_octicon_with_unknown_attribute
    investigate(cop, <<-RUBY)
      octicon(:icon, some_attribute: :value)
    RUBY

    assert_empty cop.offenses
  end

  def test_octicon_kwargs_as_method_call
    investigate(cop, <<-RUBY)
      octicon(:icon, some_call)
    RUBY

    assert_empty cop.offenses
  end
end
