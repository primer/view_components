# frozen_string_literal: true

require "test_helper"

class ResponsiveComponentTest < Minitest::Test
  def test_arguments_definition_class_method_creates_arguments_for_component
    # arrange
    klass = Class.new(Primer::Alpha::ResponsiveComponent) do
      # act
      arguments_definition(
        simple_arg: arg(
          allowed_values: [:a, :b, :c],
          default: :b
        ),
        responsive_arg: arg(
          responsive: :yes,
          type: Numeric,
          v_narrow: { default: 1 },
          v_regular: { default: 2 }
        )
      )
    end
    Object.send(:const_set, :ChildResponsiveComponent, klass)

    # assert
    simple_arg_definition = ChildResponsiveComponent.arguments[:simple_arg]
    assert_instance_of(Primer::Responsive::ArgumentDefinition, simple_arg_definition)
    assert_equal(:b, simple_arg_definition.default_value)

    responsive_arg_definition = ChildResponsiveComponent.arguments[:responsive_arg]
    assert_instance_of(Primer::Responsive::ArgumentDefinition, responsive_arg_definition)
    assert_instance_of(Primer::Responsive::ResponsiveVariantArgumentDefinition, responsive_arg_definition.responsive_variants[:v_narrow])
    assert_instance_of(Primer::Responsive::ResponsiveVariantArgumentDefinition, responsive_arg_definition.responsive_variants[:v_regular])
    assert_equal(1, responsive_arg_definition.default_value(:v_narrow))
    assert_equal(2, responsive_arg_definition.default_value(:v_regular))

    # teardown
    Object.send(:remove_const, :ChildResponsiveComponent)
  end

  def test_add_arguments_definition_class_method_inherits_parent_args
    # arrange
    parent_klass = Class.new(Primer::Alpha::ResponsiveComponent) do
      arguments_definition(
        parent_arg_a: arg(
          allowed_values: [:a, :b, :c],
          default: :b
        ),
        parent_arg_b: arg(
          responsive: :yes,
          type: String
        )
      )
    end
    Object.send(:const_set, :ParentResponsiveComponent, parent_klass)

    child_klass = Class.new(ParentResponsiveComponent) do
      # act
      add_arguments_definition(
        parent_arg_a: arg(
          type: String,
          default: "overwriting argument definition"
        ),
        child_arg: arg(
          responsive: :yes,
          type: Integer
        )
      )
    end
    Object.send(:const_set, :ChildResponsiveComponent, child_klass)

    # assert
    parent_arg_a = ChildResponsiveComponent.arguments[:parent_arg_a]
    original_arg_a = ParentResponsiveComponent.arguments[:parent_arg_a]

    parent_arg_b = ChildResponsiveComponent.arguments[:parent_arg_b]
    original_arg_b = ParentResponsiveComponent.arguments[:parent_arg_b]

    child_arg = ChildResponsiveComponent.arguments[:child_arg]

    assert_instance_of(Primer::Responsive::ArgumentDefinition, parent_arg_a)
    assert_instance_of(Primer::Responsive::ArgumentDefinition, parent_arg_b)
    assert_instance_of(Primer::Responsive::ArgumentDefinition, child_arg)

    refute_equal(original_arg_a, parent_arg_a, "Child arguments with same name should overwrite parent's argument definition")
    assert_equal(original_arg_b, parent_arg_b, "Parent's arguments should be inherited unless overwritten by Child arguments_definition")

    # teardown
    Object.send(:remove_const, :ParentResponsiveComponent)
    Object.send(:remove_const, :ChildResponsiveComponent)
  end
end
