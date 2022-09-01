# frozen_string_literal: true

require "test_helper"

class ArgumentDefinitionTest < Minitest::Test
  def test_params_validation_raises_if_not_allowed_params_found
    # arrange
    not_allowed_param = :inexistent_param
    params = {
      type: String,
      default: "Valid default"
    }
    params[not_allowed_param] = "irrelevant value"

    # act / assert
    error = assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError) do
      Primer::Responsive::ArgumentDefinition.new(params)
    end
    assert(error&.message&.include?(not_allowed_param.to_s))
  end

  def test_valid_definition_cannot_contain_type_and_allowed_values_simultaneously
    # arrange
    params = {
      type: String,
      allowed_values: %w[value_a value_b]
    }

    # act / assert
    assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError) do
      Primer::Responsive::ArgumentDefinition.new(params)
    end
  end

  def test_valid_definition_with_type_and_default_has_default_value_of_the_same_type
    # arrange
    params = {
      type: String,
      default: 10
    }

    # act / assert
    assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError) do
      Primer::Responsive::ArgumentDefinition.new(params)
    end
  end

  def test_valid_definition_with_type_and_variant_default_has_default_value_of_the_same_type
    # arrange
    params = {
      type: String,
      responsive: :yes,
      v_narrow: { default: 1 },
      v_regular: { default: 2 }
    }

    # act / assert
    assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError) do
      Primer::Responsive::ArgumentDefinition.new(params)
    end
  end

  def test_valid_definition_responsive_type_has_to_be_valid
    # arrange
    params = {
      responsive: :inexistent_responsive_option
    }

    # act / assert
    error = assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError) do
      Primer::Responsive::ArgumentDefinition.new(params)
    end
    assert(error&.message&.include?("responsive"))
  end

  def test_valid_definition_not_responsive_definition_cant_have_reponsive_variants
    # arrange
    params = {
      allowed_values: [:a, :b],
      responsive: :no,
      v_narrow: { default: :a }
    }

    # act / assert
    error = assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError) do
      Primer::Responsive::ArgumentDefinition.new(params)
    end
    assert(error&.message&.include?("responsive"))
  end

  def test_valid_definition_responsive_variants_cant_have_allowed_values_duplicates
    # arrange
    params = {
      allowed_values: [:duplicate_value, :value_a, :value_b],
      responsive: :yes,
      v_narrow: {
        additional_allowed_values: [:duplicate_value, :narrow_a]
      }
    }

    # act / assert
    assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError) do
      Primer::Responsive::ArgumentDefinition.new(params)
    end
  end

  def test_valid_definition_responsive_variants_cant_have_type_defined
    params = {
      type: String,
      responsive: :yes,
      v_narrow: { type: String }
    }

    error = assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError) do
      Primer::Responsive::ArgumentDefinition.new(params)
    end

    assert(error&.message&.include?("type"))
  end

  def test_valid_definition_fully_responsive_argument_cant_have_variant_default_and_overall_default_simultaneously
    params = {
      type: String,
      default: "overall_default",
      responsive: :yes,
      v_narrow: { default: "narrow_default" }
    }

    error = assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError) do
      Primer::Responsive::ArgumentDefinition.new(params)
    end

    assert(error&.message&.include?("default"))
  end

  def test_valid_definition_responsive_variants_require_all_default_to_be_explicit_if_at_least_one_defines_it
    params = {
      type: String,
      responsive: :yes,
      v_narrow: { default: "narrow" }
    }

    error = assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError) do
      Primer::Responsive::ArgumentDefinition.new(params)
    end

    assert(error&.message&.include?("default"))
  end

  def test_defition_valid_value_is_always_true_if_no_type_or_allowed_values_are_defined
    # arrange
    argument_definition = Primer::Responsive::ArgumentDefinition.new(
      default: 10
    )
    values = {
      string: "string value",
      numeric: "integer value",
      symbol: :sym_value,
      hash: { key: :value },
      nothing: nil
    }

    # act
    values.each_value do |value|
      # assert
      assert(
        argument_definition.valid_value?(value),
        "Value `#{value.inspect}`(#{value.class.inspect}) should be valid if no type or allowed_values is specified"
      )
    end
  end

  def test_valid_value_uses_allowed_values_to_check_for_value_validity
    # arrange
    argument_definition = Primer::Responsive::ArgumentDefinition.new(
      allowed_values: [1, 3, 5]
    )
    test_cases = {
      1 => true,
      2 => false,
      3 => true,
      4 => false,
      5 => true
    }

    # act
    test_cases.each do |value, expected|
      # assert
      assert(
        argument_definition.valid_value?(value) == expected,
        "Value `#{value.inspect}` should be #{expected.inspect} per allowed_values"
      )
    end
  end

  def test_valid_value_uses_allowed_values_to_check_for_value_validity_in_responsive_variants
    # arrange
    argument_definition = Primer::Responsive::ArgumentDefinition.new(
      responsive: :yes,
      allowed_values: [:a, :b, :c],
      v_narrow: {
        additional_allowed_values: [:na, :nb]
      },
      v_regular: {
        additional_allowed_values: [:ra]
      }
    )
    test_cases = [
      {
        variant: nil,
        value: :a,
        expected: true
      },
      {
        variant: nil,
        value: :invalid_value,
        expected: false
      },
      {
        variant: :v_narrow,
        value: :nb,
        expected: true
      },
      {
        variant: :v_narrow,
        value: :b,
        expected: true
      },
      {
        variant: :v_narrow,
        value: :ra,
        expected: false
      },
      {
        variant: :v_regular,
        value: :ra,
        expected: true
      },
      {
        variant: :v_regular,
        value: :invalid_value,
        expected: false
      },
      {
        variant: :v_wide,
        value: :a,
        expected: true
      },
      {
        variant: :v_wide,
        value: :ra,
        expected: false
      }
    ]

    # act
    test_cases.each do |test_case|
      # assert
      assert(
        argument_definition.valid_value?(test_case[:value], test_case[:variant]) == test_case[:expected],
        "Value `#{test_case[:value].inspect}` should be #{test_case[:expected].inspect} per allowed_values"
      )
    end
  end

  def test_validate_value_raises_error_if_value_has_invalid_type
    # arrange
    argument_definition = Primer::Responsive::ArgumentDefinition.new(
      type: Numeric
    )
    value = "string value"

    # act / assert
    error = assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentValueError) do
      argument_definition.validate_value(value)
    end

    assert(error&.message&.include?("type"))
  end

  def test_validate_value_raises_error_if_value_outside_allowed_values
    # arrange
    argument_definition = Primer::Responsive::ArgumentDefinition.new(
      allowed_values: [:a, :b, :c]
    )
    value = :invalid_value

    # act / assert
    assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentValueError) do
      argument_definition.validate_value(value)
    end
  end

  def test_validate_value_raises_error_if_value_outside_allowed_values_for_responsive_variants
    # arrange
    argument_definition = Primer::Responsive::ArgumentDefinition.new(
      allowed_values: [:a, :b, :c],
      responsive: :yes,
      v_narrow: {
        additional_allowed_values: [:d, :e]
      }
    )
    value = :invalid_value

    # act / assert
    assert_raises(Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentValueError) do
      argument_definition.validate_value(value, :v_narrow)
    end
  end

  def test_deprecated_value_method_is_true_for_values_deprecated
    # arrange
    argument_definition = Primer::Responsive::ArgumentDefinition.new(
      allowed_values: [:a, :b, :c],
      deprecation: {
        deprecated_values: [:d, :e]
      }
    )
    value = :d

    # act / assert
    assert(argument_definition.deprecated_value?(value))
  end
end
