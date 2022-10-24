# frozen_string_literal: true

require "test_helper"

class ArgumentsDefinitionHelperTest < Minitest::Test
  include Primer::Responsive::ArgumentsDefinitionHelper
  ARGUMENT_IDENTIFIER_KEY = Primer::Responsive::ArgumentsDefinitionHelper::ARGUMENT_IDENTIFIER_KEY

  def args_definition_input
    {
      arg_a: arg(
        responsive: :no,
        type: Integer,
        default: 0
      ),

      arg_b: arg(type: String),

      responsive_arg_c: arg(
        allowed_values: [:a, :b],
        responsive: :yes,
        v_narrow: {
          additional_allowed_values: [:n_a, :n_b],
          default: :n_a
        },
        v_regular: { default: :b },
        v_wide: { default: :a }
      ),

      arg_d: arg(
        allowed_values: [:a, :b],
        responsive: :transitional,
        default: :a,
        deprecation: {
          deprecated_values: [:aa, :bb],
          warn_message: "addtional deprecation message"
        }
      ),

      arg_ns: {
        deep_arg_a: arg(
          allowed_values: [:a, :b, :c],
          responsive: :yes
        ),

        deep_arg_b: arg(
          responsive: :transitional,
          allowed_values: [:a, :b, :c],
          default: :a,
          v_narrow: { default: :b },
          v_regular: { default: :b }
        )
      }
    }
  end

  def test_arguments_definition_builder_creates_a_hash_of_arguments_and_variants
    # arrange
    input = args_definition_input

    # act
    args_definition = arguments_definition_builder(input)

    # assert
    arg_a = args_definition[:arg_a]
    assert_instance_of(Primer::Responsive::ArgumentDefinition, arg_a)
    assert_equal(:arg_a, arg_a.name)
    assert_equal(false, arg_a.responsive?)
    assert_equal(true, arg_a.defined_default?)
    assert_equal(0, arg_a.default_value)
    assert_equal(false, arg_a.required?)

    arg_b = args_definition[:arg_b]
    assert_instance_of(Primer::Responsive::ArgumentDefinition, arg_b)
    assert_equal(:arg_b, arg_b.name)
    assert_equal(false, arg_b.responsive?)
    assert_equal(false, arg_b.defined_default?)
    assert_equal(true, arg_b.required?)

    responsive_arg_c = args_definition[:responsive_arg_c]
    assert_instance_of(Primer::Responsive::ArgumentDefinition, responsive_arg_c)
    assert_equal(:responsive_arg_c, responsive_arg_c.name)
    assert_equal(true, responsive_arg_c.responsive?)
    assert_equal(false, responsive_arg_c.defined_default?)
    assert_equal(false, responsive_arg_c.required?)
    assert_instance_of(
      Primer::Responsive::ResponsiveVariantArgumentDefinition,
      responsive_arg_c.responsive_variants[:v_narrow]
    )
    assert_equal(true, responsive_arg_c.defined_default?(:v_narrow))
    assert_equal(:n_a, responsive_arg_c.default_value(:v_narrow))
    assert_instance_of(
      Primer::Responsive::ResponsiveVariantArgumentDefinition,
      responsive_arg_c.responsive_variants[:v_regular]
    )
    assert_equal(true, responsive_arg_c.defined_default?(:v_regular))
    assert_equal(:b, responsive_arg_c.default_value(:v_regular))
    assert_instance_of(
      Primer::Responsive::ResponsiveVariantArgumentDefinition,
      responsive_arg_c.responsive_variants[:v_wide]
    )
    assert_equal(true, responsive_arg_c.defined_default?(:v_wide))
    assert_equal(:a, responsive_arg_c.default_value(:v_wide))

    transitional_arg_d = args_definition[:arg_d]
    assert_instance_of(Primer::Responsive::ArgumentDefinition, transitional_arg_d)
    assert_equal(:arg_d, transitional_arg_d.name)
    assert_equal(true, transitional_arg_d.responsive?)
    assert_equal(true, transitional_arg_d.defined_default?)
    assert_equal(false, transitional_arg_d.required?)
    assert_equal(:a, transitional_arg_d.default_value)
    assert_instance_of(Primer::Responsive::ArgumentDeprecation, transitional_arg_d.deprecation)
    assert_equal(true, transitional_arg_d.deprecated_value?(:aa))
    assert(
      transitional_arg_d
      .deprecation_warn_message(:aa)
      .include?(
        input[:arg_d][ARGUMENT_IDENTIFIER_KEY][:deprecation][:warn_message]
      )
    )

    namespace = args_definition[:arg_ns]
    assert_kind_of(Hash, namespace)

    nested_deep_arg_a = namespace[:deep_arg_a]
    assert_instance_of(Primer::Responsive::ArgumentDefinition, nested_deep_arg_a)
    assert(nested_deep_arg_a.responsive?(:yes))

    nested_deep_arg_b = namespace[:deep_arg_b]
    assert_instance_of(Primer::Responsive::ArgumentDefinition, nested_deep_arg_b)
    assert(nested_deep_arg_b.responsive?(:transitional))
  end

  def test_normalize_argument_values_sets_default_to_missing_values
    # arrange
    args_definition = arguments_definition_builder(
      arg_a: arg(
        type: String,
        default: "default value"
      ),
      arg_b: arg(
        type: Integer,
        default: 100
      )
    )
    values = {
      arg_b: -1
    }

    # act
    normalized_values = normalize_argument_values!(
      arguments_definition: args_definition,
      argument_values: values.deep_dup,
      fallback_to_default: true
    )

    # assert
    assert_equal(args_definition[:arg_a].default_value, normalized_values[:arg_a])
    assert_equal(values[:arg_b], normalized_values[:arg_b])
  end

  def test_normalize_argument_values_spreads_fully_responsive_values
    # arrange
    args_definition = arguments_definition_builder(
      arg_a: arg(
        responsive: :yes,
        allowed_values: [:a, :b, :c],
        default: :a
      )
    )
    values = {
      arg_a: :b
    }

    # act
    normalized_values = normalize_argument_values!(
      arguments_definition: args_definition,
      argument_values: values.deep_dup,
      fallback_to_default: true
    )

    # assert
    assert_equal(false, normalized_values.key?(:arg_a), "Fully responsive args base values have to be moved into responsive variants")
    assert_equal(values[:arg_a], normalized_values[:v_narrow][:arg_a], "Fully responsive args base values have to be moved into responsive variants")
    assert_equal(values[:arg_a], normalized_values[:v_regular][:arg_a], "Fully responsive args base values have to be moved into responsive variants")
    assert_equal(false, normalized_values.fetch(:v_wide, {}).key?(:arg_a), "Optional responsive variants shouldn't be added implicitly")
  end

  def test_normalize_argument_values_only_spreads_transitional_responsive_value_if_explicitly_set_into_variants
    # arrange
    args_definition = arguments_definition_builder(
      arg_a: arg(
        responsive: :transitional,
        allowed_values: [:a, :b, :c],
        default: :a
      ),
      arg_b: arg(
        responsive: :transitional,
        allowed_values: [:ta, :tb, :tc],
        default: :tc,
        v_narrow: { default: :ta },
        v_regular: { default: :tb }
      )
    )
    values = {
      # setting as base value
      arg_a: :b,

      # setting as responsive value
      v_narrow: {
        arg_b: :tc
      }
    }

    # act
    normalized_values = normalize_argument_values!(
      arguments_definition: args_definition,
      argument_values: values.deep_dup,
      fallback_to_default: true
    )

    # assert
    assert(normalized_values.key?(:arg_a), "Transitional responsive don't remove base values")
    assert_equal(values[:arg_a], normalized_values[:arg_a])
    assert_equal(false, normalized_values.fetch(:v_narrow, {}).key?(:arg_a), "Transitional responsive variants shouldn't be added implicitly")

    assert_equal(values[:v_narrow][:arg_b], normalized_values[:v_narrow][:arg_b])
    assert_equal(args_definition[:arg_b].default_value(:v_regular), normalized_values[:v_regular][:arg_b])
  end

  def test_normalize_argument_values_uses_base_default_value_for_responsive_value_unless_responsive_variants_are_present_in_the_values
    # arrange
    args_definition = arguments_definition_builder(
      arg_a: arg(
        responsive: :transitional,
        allowed_values: [:t_default, :t_narrow, :t_regular, :t_wide, :t_extra, :t_extra2],
        default: :t_default,
        v_narrow: { default: :t_narrow },
        v_regular: { default: :t_regular }
      )
    )
    # arrange: test cases
    values_empty = {}
    values_base_value = { arg_a: :t_extra }
    values_incomplete_variants = {
      v_narrow: { arg_a: :t_extra }
    }
    values_all_variants = {
      v_narrow: { arg_a: :t_extra },
      v_regular: { arg_a: :t_extra2 }
    }

    # act
    normalized_empty = normalize_argument_values!(arguments_definition: args_definition, argument_values: values_empty.deep_dup)

    normalized_base_value = normalize_argument_values!(arguments_definition: args_definition, argument_values: values_base_value.deep_dup)

    normalized_incomplete_variants = normalize_argument_values!(arguments_definition: args_definition, argument_values: values_incomplete_variants.deep_dup)

    normalized_all_variants = normalize_argument_values!(arguments_definition: args_definition, argument_values: values_all_variants.deep_dup)

    # assert
    assert_equal(:t_default, normalized_empty[:arg_a])
    assert_equal(false, normalized_empty.key?(:v_narrow))
    assert_equal(false, normalized_empty.key?(:v_regular))

    assert_equal(:t_extra, normalized_base_value[:arg_a])
    assert_equal(false, normalized_base_value.key?(:v_narrow))
    assert_equal(false, normalized_base_value.key?(:v_regular))

    assert_equal(false, normalized_incomplete_variants.key?(:arg_a))
    assert_equal(true, normalized_incomplete_variants.key?(:v_narrow))
    assert_equal(:t_extra, normalized_incomplete_variants[:v_narrow][:arg_a])
    assert_equal(true, normalized_incomplete_variants.key?(:v_regular))
    assert_equal(:t_regular, normalized_incomplete_variants[:v_regular][:arg_a])

    assert_equal(false, normalized_all_variants.key?(:arg_a))
    assert_equal(true, normalized_all_variants.key?(:v_narrow))
    assert_equal(:t_extra, normalized_all_variants[:v_narrow][:arg_a])
    assert_equal(true, normalized_all_variants.key?(:v_regular))
    assert_equal(:t_extra2, normalized_all_variants[:v_regular][:arg_a])
  end

  def test_normalize_argument_values_fallback_to_default_when_invalid_value_present
    # arrange
    args_definition = arguments_definition_builder(
      arg_a: arg(
        responsive: :no,
        allowed_values: [:a, :b, :c],
        default: :a
      ),
      arg_r: arg(
        responsive: :yes,
        allowed_values: [:ra, :rb],
        v_narrow: {
          additional_allowed_values: [:rna, :rnb],
          default: :rnb
        },
        v_regular: {
          additional_allowed_values: [:rra, :rrb],
          default: :rra
        },
        v_wide: { default: :rb }
      ),
      arg_t: arg(
        responsive: :transitional,
        allowed_values: [:ta, :tb, :tc],
        default: :tc,
        v_narrow: { default: :ta },
        v_regular: { default: :tb }
      )
    )
    values = {
      arg_a: :invalid_value,
      v_narrow: {
        arg_r: :rra # this value is not available for narrow, only for regular
      },
      v_regular: {
        arg_r: :rc # invalid value
      },
      v_wide: {
        arg_r: :rna, # this value is not available for wide, only for narrow
        arg_t: :td # invalid value for undefined variant in transitional
      }
    }

    # act
    normalized_values = normalize_argument_values!(
      arguments_definition: args_definition,
      argument_values: values.deep_dup,
      fallback_to_default: true
    )

    # assert
    assert_equal(:a, normalized_values[:arg_a], "Invalid value should fallback to default")

    assert_equal(args_definition[:arg_r].default_value(:v_narrow), normalized_values[:v_narrow][:arg_r])
    assert_equal(args_definition[:arg_r].default_value(:v_regular), normalized_values[:v_regular][:arg_r])
    assert_equal(args_definition[:arg_r].default_value(:v_wide), normalized_values[:v_wide][:arg_r])

    assert_equal(args_definition[:arg_t].default_value(:v_narrow), normalized_values[:v_narrow][:arg_t])
    assert_equal(args_definition[:arg_t].default_value(:v_regular), normalized_values[:v_regular][:arg_t])
    assert_equal(args_definition[:arg_t].default_value, normalized_values[:v_wide][:arg_t])
  end

  def test_normalize_argument_values_with_deep_arguments_definitions
    # arrange
    args_definition = arguments_definition_builder(
      one_lvl_deep: {
        arg_no: arg(type: String, default: "default value"),
        arg_responsive: arg(
          responsive: :yes,
          allowed_values: [:a, :b, :c],
          v_narrow: { default: :a },
          v_regular: { default: :b }
        ),
        arg_transitional: arg(
          responsive: :transitional,
          type: Numeric,
          default: -1
        )
      },
      multiple_lvls_deep: {
        level_a: {
          level_a_a: {
            arg_no: arg(type: String, default: "default value"),
            arg_responsive: arg(
              responsive: :yes,
              allowed_values: [:a, :b, :c],
              v_narrow: { default: :a },
              v_regular: { default: :b }
            ),
            arg_transitional: arg(
              responsive: :transitional,
              type: Numeric,
              default: -1
            )
          },
          level_a_b: arg(
            type: Integer,
            default: 100
          )
        },
        level_b: {
          arg_no: arg(type: String, default: "default value"),
          arg_responsive: arg(
            responsive: :yes,
            allowed_values: [:a, :b, :c],
            v_narrow: { default: :a },
            v_regular: { default: :b }
          ),
          arg_transitional: arg(
            responsive: :transitional,
            type: Numeric,
            default: -1
          )
        }
      }
    )
    values = {
      one_lvl_deep: {
        arg_no: :invalid_value,
        arg_transitional: :invalid_value
      },
      multiple_lvls_deep: {
        level_b: {
          arg_no: "valid value"
        }
      },
      v_narrow: {
        one_lvl_deep: { arg_responsive: :c },
        multiple_lvls_deep: {
          level_a: {
            level_a_a: { arg_responsive: :invalid_value }
          }
        }
      },
      v_regular: {
        one_lvl_deep: { arg_responsive: :invalid_value }
      }
    }

    # act
    normalized_values = normalize_argument_values!(
      arguments_definition: args_definition,
      argument_values: values.deep_dup,
      fallback_to_default: true
    )

    # assert
    assert_equal(
      args_definition[:one_lvl_deep][:arg_no].default_value,
      normalized_values[:one_lvl_deep][:arg_no],
      "Invalid value should fallback to default"
    )
    assert_equal(
      args_definition[:one_lvl_deep][:arg_transitional].default_value,
      normalized_values[:one_lvl_deep][:arg_transitional],
      "Transitional argument with invalid base value should fallback to default in a non-responsive fashion"
    )

    assert_equal(
      args_definition[:multiple_lvls_deep][:level_a][:level_a_a][:arg_no].default_value,
      normalized_values[:multiple_lvls_deep][:level_a][:level_a_a][:arg_no],
      "Invalid value will fallback to default even in nested arguments"
    )
    assert_equal(
      args_definition[:multiple_lvls_deep][:level_a][:level_a_a][:arg_transitional].default_value,
      normalized_values[:multiple_lvls_deep][:level_a][:level_a_a][:arg_transitional],
      "Missing value for nested argument is set to default"
    )
    assert_equal(
      values[:multiple_lvls_deep][:level_b][:arg_no],
      normalized_values[:multiple_lvls_deep][:level_b][:arg_no],
      "Valid value for nested argument doesn't fallback to default"
    )
    assert_equal(
      args_definition[:multiple_lvls_deep][:level_b][:arg_transitional].default_value,
      normalized_values[:multiple_lvls_deep][:level_b][:arg_transitional],
      "Missing value for nested argument is set to default"
    )

    assert_equal(
      values[:v_narrow][:one_lvl_deep][:arg_responsive],
      normalized_values[:v_narrow][:one_lvl_deep][:arg_responsive],
      "Valid responsive values don't fallback to default"
    )
    assert_equal(
      args_definition[:one_lvl_deep][:arg_responsive].default_value(:v_regular),
      normalized_values[:v_regular][:one_lvl_deep][:arg_responsive],
      "Invalid responsive value for nested argument is normalized and set to default"
    )

    assert_equal(
      args_definition[:multiple_lvls_deep][:level_a][:level_a_a][:arg_responsive].default_value(:v_narrow),
      normalized_values[:v_narrow][:multiple_lvls_deep][:level_a][:level_a_a][:arg_responsive],
      "Invalid responsive value for nested argument is normalized and set to default"
    )
    assert_equal(
      args_definition[:multiple_lvls_deep][:level_a][:level_a_a][:arg_responsive].default_value(:v_regular),
      normalized_values[:v_regular][:multiple_lvls_deep][:level_a][:level_a_a][:arg_responsive],
      "Missing responsive value for nested argument is normalized and set to default"
    )

    assert_equal(
      args_definition[:multiple_lvls_deep][:level_b][:arg_responsive].default_value(:v_narrow),
      normalized_values[:v_narrow][:multiple_lvls_deep][:level_b][:arg_responsive],
      "Missing responsive value for nested argument is normalized and set to default"
    )
    assert_equal(
      args_definition[:multiple_lvls_deep][:level_b][:arg_responsive].default_value(:v_regular),
      normalized_values[:v_regular][:multiple_lvls_deep][:level_b][:arg_responsive],
      "Missing responsive value for nested argument is normalized and set to default"
    )
  end
end
