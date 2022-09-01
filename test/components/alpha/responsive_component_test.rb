# frozen_string_literal: true

require "test_helper"

class ResponsiveComponentTest < Minitest::Test
  def test_setting_allowed_html_attributes_are_saevd_in_class_instane
    # arrange
    expected_attrs = [:custom_attribute, :src]
    klass_additional = Class.new(Primer::Alpha::ResponsiveComponent) do
      # act
      additional_allowed_html_attributes :custom_attribute, :src
    end

    klass_strict = Class.new(Primer::Alpha::ResponsiveComponent) do
      # act
      allowed_html_attributes :custom_attribute, :src
    end

    # assert
    assert_equal(expected_attrs, klass_additional.saved_allowed_html_attributes, "Additional allowed attributes should be saved to the class instance")
    assert_equal(expected_attrs, klass_strict.saved_allowed_html_attributes, "Allowed attributes should be saved to the class instance")
  end

  def test_setting_addtional_allowed_html_attributes_includes_global_attributes_when_sanitizing
    # arrange
    additional_attrs = [:custom_attribute, :src]
    klass = Class.new(Primer::Alpha::ResponsiveComponent) do
      additional_allowed_html_attributes additional_attrs
    end
    instance = klass.new(
      html_attributes: {
        invalid_attr: "dummy value",
        id: "dummy-id",
        class: "dummy-class",
        src: "protocol://dummy-url.domain/dummy-resource",
        custom_attribute: "dummy attribute value"
      }
    )

    # act
    sanitized_html_attrs = instance.sanitize_html_attributes

    # assert
    assert((sanitized_html_attrs.keys & [:invalid_attr]).empty?, "`invalid_attr` should be removed from the sanitized html_attributes if allowed_html_attributes was set properly")
  end

  def test_setting_allowed_html_attributes_sanitizes_attributes_strictly
    # arrange
    additional_attrs = [:custom_attribute, :src]
    klass = Class.new(Primer::Alpha::ResponsiveComponent) do
      allowed_html_attributes additional_attrs
    end
    instance = klass.new(
      html_attributes: {
        invalid_attr: "dummy value",
        id: "dummy-id",
        class: "dummy-class",
        src: "protocol://dummy-url.domain/dummy-resource",
        custom_attribute: "dummy attribute value"
      }
    )

    # act
    sanitized_html_attrs = instance.sanitize_html_attributes

    # assert
    assert((sanitized_html_attrs.keys & [:invalid_attr, :id, :class]).empty?, "Only #{additional_attrs.inspect} should exist in html_attributes after sanitization")
  end

  def test_sanitize_html_attributes_with_bang_updates_instance_html_attributes
    # arrange
    klass = Class.new(Primer::Alpha::ResponsiveComponent) do
      # overriding initialize here to invoke sanitize_html_attributes! explicitly afterwards
      def initialize(argument_values: {}, html_attributes: {})
        @argument_values = argument_values
        @html_attributes = html_attributes
      end
    end
    html_attrs = {
      invalid_attr: "dummy value",
      id: "dummy-id",
      class: "dummy-class"
    }

    instance = klass.new(html_attributes: html_attrs)

    # act
    assert_equal(html_attrs, instance.html_attributes)

    instance.sanitize_html_attributes!

    # assert
    assert((instance.html_attributes.keys & [:invalid_attr]).empty?, "`invalid_attr` should've been removed from the html_attributes")
  end

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

  def test_normalize_values_removes_invalid_arguments_and_fill_missing_or_invalid_values_with_defaults
    # arrange
    klass = Class.new(Primer::Alpha::ResponsiveComponent) do
      arguments_definition(
        simple_arg: arg(
          allowed_values: [:a, :b, :c],
          default: :b
        ),
        responsive_arg: arg(
          responsive: :yes,
          type: Numeric,
          v_narrow: { default: 1 },
          v_regular: { default: 2 },
          v_wide: { default: 5 }
        ),
        arg_namespace: {
          nested_simple_arg: arg(
            type: String,
            default: "default value"
          ),
          nested_responsive_arg: arg(
            responsive: :yes,
            allowed_values: [:inner_a, :inner_b],
            v_narrow: {
              additional_allowed_values: [:inner_na],
              default: :inner_na
            },
            v_regular: { default: :inner_b }
          )
        }
      )
    end
    values = {
      simple_arg: :invalid_value,
      arg_namespace: {
        nested_simple_arg: "valid value"
      },
      v_narrow: {
        arg_namespace: {
          nested_responsive_arg: :inner_a
        },
        responsive_arg: 10
      }
    }

    expected_normalized_values = {
      simple_arg: :b, 
      arg_namespace: {
        nested_simple_arg: "valid value"
      },
      v_narrow: {
        arg_namespace: {
          nested_responsive_arg: :inner_a
        },
        responsive_arg: 10
      },
      v_regular: {
        responsive_arg: 2,
        arg_namespace: {
          nested_responsive_arg: :inner_b
        }
      },
      v_wide: {
        responsive_arg: 5
      }
    }

    instance = klass.new(argument_values: values)

    # act
    normalized_values = instance.normalize_values!

    # assert
    assert_equal(expected_normalized_values, normalized_values, "Normalized_values don't match expected output")
  end

  def test_style_class_map_responsive_will_add_responsive_variants_to_class_map
    # arrange
    klass = Class.new(Primer::Alpha::ResponsiveComponent) do
      # act
      style_class_map(
        general: {
          arg_a: {
            value_a: "class-a-value-a",
            value_b: "class-a-value-b"
          },
          arg_b: {
            value_a: "class-b-value-a",
            value_b: "class-b-value-b"
          }
        },
        responsive: {
          arg_c: {
            value_a: "class-c-value-a",
            value_b: "class-c-value-b"
          }
        },
        with_responsive: {
          arg_d: {
            value_a: "class-d-value-a",
            value_b: "class-d-value-b"
          },
          arg_namespace: {
            arg_e: {
              value_a: "class-ns-e-value-a",
              value_b: "class-ns-e-value-b"
            }
          }
        }
      )
    end

    expected_base_keys = [
      :arg_a, :arg_b, # from :general
      :arg_d, :arg_namespace # from :with_responsive
    ]
    responsive_keys = [
      :arg_c, # from :responsive
      :arg_d, :arg_namespace # from :with_responsive
    ]

    instance = klass.new

    # assert
    assert_equal(expected_base_keys.size, (expected_base_keys & instance.style_class_map.keys).size, "general and with_responsive must keep the base arguments in the class map root")
    assert_equal(responsive_keys, instance.style_class_map[:v_narrow].keys, "all responsive arguments have to be part of the :v_narrow class map")
    assert_equal(responsive_keys, instance.style_class_map[:v_regular].keys, "all responsive arguments have to be part of the :v_regular class map")
    assert_equal(responsive_keys, instance.style_class_map[:v_wide].keys, "all responsive arguments have to be part of the :v_wide class map")
  end
end
