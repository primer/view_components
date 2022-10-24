# frozen_string_literal: true

require "test_helper"

class StyleClassMapHelperTest < Minitest::Test
  include Primer::Responsive::StyleClassMapHelper

  def test_build_responsive_variant_replicates_the_map_structure_adding_class_variant_to_each_map_item
    # arrange
    base_style_class_map = {
      arg_a: {
        arg_a_value_a: "argument-a-value-a",
        arg_a_value_b: "argument-a-value-b",
        arg_a_value_c: "argument-a-value-c"
      }
    }
    modifier = "class-modifier"
    expected_class_map = {
      arg_a: {
        arg_a_value_a: derive_class_variant("argument-a-value-a", modifier),
        arg_a_value_b: derive_class_variant("argument-a-value-b", modifier),
        arg_a_value_c: derive_class_variant("argument-a-value-c", modifier)
      }
    }

    # act
    built_class_map = build_responsive_variant(base_style_class_map, modifier)

    # assert
    assert_equal(expected_class_map.keys, built_class_map.keys, "Built class map has to replicate the base class map structure")
    built_class_map.each do |key, value|
      assert_equal(expected_class_map[key].keys, value.keys, "Built class map has to replicate the base class map structure")
      assert_equal(expected_class_map[key].values, value.values, "Built class map doesn't have all classes modified properly")
    end
  end

  def test_build_responsive_variant_replicates_deep_argument_structures
    # arrange
    base_style_class_map = {
      arg_a: {
        argt_a_value_a: "argument-a-value-a",
        arg_a_value_b: "argument-a-value-b",
        arg_a_value_c: "argument-a-value-c"
      },
      arg_b: {
        arg_b_value_a: "argument-b-value-a",
        arg_b_value_b: "argument-b-value-b",
        arg_b_value_c: "argument-b-value-c",
        arg_b_value_d: "argument-b-value-d"
      },
      arg_namespace_lvl1: {
        inner_arg_a: {
          inner_arg_a_value_a: "inner-argument-a-value-a",
          inner_arg_a_value_b: "inner-argument-a-value-b"
        },
        arg_namespace_lvl2: {
          deep_arg_a: {
            deep_arg_a_value_a: "deep-argument-a-value-a",
            deep_arg_a_value_b: "deep-argument-a-value-b"
          },
          deep_arg_b: {
            deep_arg_a_value_a: "deep-argument-a-value-a",
            deep_arg_a_value_b: "deep-argument-a-value-b"
          }
        }
      }
    }
    modifier = "modifier"

    # act
    built_class_map = build_responsive_variant(base_style_class_map, modifier)

    # assert
    assert_equal(base_style_class_map.keys, built_class_map.keys, "Built class map has to replicate the base class map structure")
    built_class_map.each do |key, value|
      assert_equal(base_style_class_map[key].keys, value.keys, "Built class map has to replicate the base class map structure")
    end

    # lvl1
    built_class_map[:arg_namespace_lvl1].each do |key, value|
      assert_equal(base_style_class_map[:arg_namespace_lvl1][key].keys, value.keys, "Built class map has to replicate the base class map structure")
    end

    # lvl2
    built_class_map[:arg_namespace_lvl1][:arg_namespace_lvl2].each do |key, value|
      assert_equal(base_style_class_map[:arg_namespace_lvl1][:arg_namespace_lvl2][key].keys, value.keys, "Built class map has to replicate the base class map structure")
    end
  end

  def test_add_reponsive_variant_adds_the_variant_to_the_base_map_replicating_its_structure
    # arrange
    style_class_map = {
      arg_a: {
        value_a: "class-a-a",
        value_b: "class-a-b"
      },
      arg_b: {
        value_a: "class-b-a",
        value_b: "class-b-b"
      },
      arg_namespace: {
        arg_aa: {
          value_a: "deep-class-aa-a",
          value_b: "deep-class-aa-b"
        },
        arg_bb: {
          value_a: "deep-class-bb-a",
          value_b: "deep-class-bb-b"
        }
      }
    }
    cloned_style_class_map = style_class_map.deep_dup
    responsive_variant = :custom_responsive_variant
    modifier = "dummy-modifier"

    # act
    add_responsive_variant!(style_class_map, responsive_variant, modifier)

    # assert
    assert(style_class_map.key?(responsive_variant), "Expected variant was not added to the class map")
    assert_equal(cloned_style_class_map.keys, style_class_map[responsive_variant].keys, "Added responsive variant should have the same structure of the base map")

    # assert recursion
    assert_equal(
      cloned_style_class_map[:arg_namespace].keys,
      style_class_map[responsive_variant][:arg_namespace].keys,
      "Added responsive variant should have the same structure of the base map"
    )
  end

  def test_add_responsive_variants_adds_all_configured_variants_to_class_map
    # arrange
    responsive_variants = Primer::Responsive::ResponsiveConfig::RESPONSIVE_VARIANTS
    style_class_map = {
      arg_a: {
        value_a: "class-a-a",
        value_b: "class-a-b"
      },
      arg_b: {
        value_a: "class-b-a",
        value_b: "class-b-b"
      }
    }
    cloned_style_class_map = style_class_map.deep_dup

    # act
    add_responsive_variants!(style_class_map)

    # assert
    responsive_variants.each do |variant|
      assert_includes(style_class_map, variant, "Missing variant defined in the configuration in the final class_map")

      assert_equal(cloned_style_class_map.keys, style_class_map[variant].keys, "Internal variant doesn't match base class_map structure")
    end
  end

  def test_apply_values_to_style_map_returns_a_map_with_all_responsive_variants_mapped_to_arguments
    # arrange
    style_map = {
      arg_a: {
        value_a: "class-a-value-a",
        value_b: "class-a-value-b",
        value_c: "class-a-value-c"
      },

      extra_arg_a: {
        value_a: "extra-class-a-value-a",
        value_b: "extra-class-a-value-b",
        value_c: "extra-class-a-value-c"
      },

      v_narrow: {
        arg_b: {
          value_a: "class-b-value-a-whenNarrow",
          value_b: "class-b-value-b-whenNarrow",
          value_c: "class-b-value-c-whenNarrow"
        },
        arg_c: {
          value_a: "class-c-value-a-whenNarrow",
          value_b: "class-c-value-b-whenNarrow",
          value_c: "class-c-value-c-whenNarrow"
        }
      },
      v_regular: {
        arg_b: {
          value_a: "class-b-value-a-whenRegular",
          value_b: "class-b-value-b-whenRegular",
          value_c: "class-b-value-c-whenRegular"
        },
        arg_c: {
          value_a: "class-c-value-a-whenRegular",
          value_b: "class-c-value-b-whenRegular",
          value_c: "class-c-value-c-whenRegular"
        }
      },
      v_wide: {
        arg_b: {
          value_a: "class-b-value-a-whenWide",
          value_b: "class-b-value-b-whenWide",
          value_c: "class-b-value-c-whenWide"
        },
        arg_c: {
          value_a: "class-c-value-a-whenWide",
          value_b: "class-c-value-b-whenWide",
          value_c: "class-c-value-c-whenWide"
        }
      }
    }
    values = {
      arg_a: :value_a,
      v_narrow: {
        arg_b: :value_a,
        arg_c: :value_a
      },
      v_regular: {
        arg_b: :value_b,
        arg_c: :value_b
      },
      v_wide: {
        arg_b: :value_c,
        arg_c: :value_c
      }
    }
    expected_applied_map = {
      arg_a: "class-a-value-a",
      arg_b: "class-b-value-a-whenNarrow class-b-value-b-whenRegular class-b-value-c-whenWide",
      arg_c: "class-c-value-a-whenNarrow class-c-value-b-whenRegular class-c-value-c-whenWide"
    }

    # act
    applied_map = apply_values_to_style_map(style_map, values)

    # assert
    assert_equal(expected_applied_map.keys, applied_map.keys, "Applied map must contain all arguments present in the class map and given values")
    expected_applied_map.each do |argument, classes|
      assert_equal(classes, applied_map[argument], "Classes for given argument not composed correctly")
    end
  end
end
