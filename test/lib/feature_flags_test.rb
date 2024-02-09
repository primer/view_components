# frozen_string_literal: true

require "lib/test_helper"
require "primer/view_components/feature_flags"

class Primer::ViewComponents::FeatureFlagsTest < Minitest::Test
  TEST_FLAGS = [{ name: :primer_test_flag, description: "A flag used only in tests" }]

  def test_all_flags_are_namespaced
    Primer.feature_flags.all_flags.each do |flag|
      assert flag[:name].to_s.start_with?("primer_"), "#{flag[:name]}: all feature flags must start with 'primer_'"
    end
  end

  def test_enabled
    Primer.feature_flags.with_flags(TEST_FLAGS) do
      refute Primer.feature_flags.enabled?(:primer_test_flag)

      Primer.feature_flags.with_enabled_flags(:primer_test_flag) do
        assert Primer.feature_flags.enabled?(:primer_test_flag)
      end
    end
  end

  def test_disabled_by_default
    Primer.feature_flags.with_flags(TEST_FLAGS) do
      refute Primer.feature_flags.enabled?(:primer_test_flag)
    end
  end

  def test_enabled_flags
    Primer.feature_flags.with_flags(TEST_FLAGS) do
      Primer.feature_flags.with_enabled_flags(:primer_test_flag) do
        assert Primer.feature_flags.enabled_flags.to_a == [:primer_test_flag]
      end
    end
  end

  def test_clearing_flags
    Primer.feature_flags.with_flags(TEST_FLAGS) do
      Primer.feature_flags.with_enabled_flags(:primer_test_flag) do
        assert Primer.feature_flags.enabled_flags.to_a == [:primer_test_flag]
        Primer.feature_flags.clear
        assert Primer.feature_flags.enabled_flags.to_a == []
      end
    end
  end
end
