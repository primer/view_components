# frozen_string_literal: true

require "lib/test_helper"
Dir["app/components/**/*.rb"].each { |file| require_relative "../../#{file}" }

class DeprecationsTest < Minitest::Test
  def setup
    @deprecated_components = Primer::Deprecations.deprecated_components
  end

  def test_default_deprecations_are_loaded
    component = "Primer::BlankslateComponent"
    replacement = "Primer::Beta::Blankslate"

    assert Primer::Deprecations.deprecated?(component)
    assert Primer::Deprecations.correctable?(component)
    assert_equal Primer::Deprecations.replacement(component), replacement
    assert_nil Primer::Deprecations.guide(component)
  end

  def test_registering_deprecations
    component = "Custom::CoolComponent"
    options = {
      autocorrect: false,
      replacement: "Custom::Beta::Cool",
      guide: "https://example.com/some/component-guide"
    }

    Primer::Deprecations.register_deprecation(component, options)

    assert Primer::Deprecations.deprecated?(component)
    refute Primer::Deprecations.correctable?(component)
    assert_equal Primer::Deprecations.replacement(component), options[:replacement]
    assert_equal Primer::Deprecations.guide(component), options[:guide]
  ensure
    Primer::Deprecations.remove_deprecation(component)
  end

  # ensure all components that has 'status: :deprecated' are listed in the component deprecations configuration file
  Primer::Component.descendants.each do |component_class|
    class_test_name = component_class.name.downcase.gsub("::", "_")
    define_method("test_ensure_#{class_test_name}_is_properly_deprecated") do
      if component_class.deprecated? # rubocop:disable Style/IfUnlessModifier
        assert @deprecated_components.include?(component_class.name), missing_deprecation_message(component_class)
      end
    end
  end

  # ensure all components listed in the 'deprecations.yml' configuration are valid PVC components
  Primer::Deprecations.deprecated_components.each do |component_name|
    class_test_name = component_name.downcase.gsub("::", "_")
    define_method("test_ensure_configured_deprecation_for_#{class_test_name}_correlates_to_pvc_component") do
      has_component = Object.const_defined?(component_name)
      assert has_component, missing_component_message(component_name)

      if has_component # rubocop:disable Style/IfUnlessModifier
        component_class = component_name.constantize
        assert component_class <= Primer::Component, non_component_message(component_name)
        assert component_class.deprecated?, component_not_deprecated_message(component_class)
      end
    end
  end

  private

  def missing_deprecation_message(component_class)
    "PVC Component '#{component_class.name}' has a 'status' of ':deprected', but is not listed in the deprecations.yml file. Please update the deprecations configuration in 'lib/primer/deprecations.yml'"
  end

  def missing_component_message(component_name)
    "A deprecation entry was found in 'lib/deprecations/deprecations.yml' for '#{component_name}', but this name is not a valid Ruby const"
  end

  def non_component_message(component_name)
    "A deprecation entry was found in 'lib/deprecations/deprecations.yml' for '#{component_name}', but this is not a valid PVC component. All components must inherit 'Primer::Component'"
  end

  def component_not_deprecated_message(component_class)
    "A deprecation entry was found in 'lib/deprecations/deprecations.yml' for '#{component_class.name}', but this component is not deprecated. Current status: #{component_class.status}"
  end
end
