# frozen_string_literal: true

require "lib/test_helper"
require_relative "../../lib/primer/view_components/statuses"

Dir["app/components/**/*.rb"].each { |file| require_relative "../../#{file}" }

class DeprecationsTest < Minitest::Test
  def setup
    @deprecated_components = Primer::Deprecations.deprecated_components
  end

  def test_default_pvc_deprecations_are_loaded
    component = "Primer::BlankslateComponent"
    replacement = "Primer::Beta::Blankslate"

    assert Primer::Deprecations.deprecated?(component)
    assert Primer::Deprecations.correctable?(component)
    assert_equal Primer::Deprecations.replacement(component), replacement
    assert_nil Primer::Deprecations.guide(component)
  end

  def test_custom_deprecations
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
  end

  def test_deprecated_components_by_status_list
    deprecated_by_status = Primer::ViewComponents::STATUSES.select { |_, value| value == "deprecated" }.keys.sort
    deprecated_by_list = ::Primer::Deprecations.deprecated_components

    unmatched = deprecated_by_status - deprecated_by_list
    assert_empty(unmatched, components_not_in_deprecated_status_list_message(unmatched))
  end

  # ensure all components that have 'status: :deprecated' are listed in the component deprecations configuration file
  Primer::Component.descendants.each do |component_class|
    class_test_name = component_class.name.downcase.gsub("::", "_")
    define_method("test_ensure_#{class_test_name}_is_properly_deprecated") do
      return unless component_class.deprecated?

      assert @deprecated_components.include?(component_class.name), missing_deprecation_message(component_class)
    end
  end

  # loop through all the registered deprecations in `lib/primer/deprecations.yml`
  Primer::Deprecations.deprecated_components.each do |component_name|
    class_test_name = component_name.downcase.gsub("::", "_")

    # ensure all components listed in deprecations.yml are PVC components
    define_method("test_ensure_configured_deprecation_for_#{class_test_name}_correlates_to_pvc_component") do
      has_component = Object.const_defined?(component_name)
      assert has_component, missing_component_message(component_name)

      if has_component
        component_class = component_name.constantize
        assert component_class <= Primer::Component, non_component_message(component_name)
        assert component_class.deprecated?, component_not_deprecated_message(component_class)
      end
    end

    # ensure all components listed in deprecations.yml have a valid configuration
    define_method("test_ensure_#{class_test_name}_has_valid_deprecation_configuration") do
      component_class = component_name.constantize
      return unless component_class.deprecated?

      assert deprecation_configuration_valid?(component_name), invalid_configuration_message(component_name)
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

  def components_not_in_deprecated_status_list_message(_list)
    msg = []
    msg << "The deprecated component list in 'static/statuses.json' does not match the list in 'lib/primer/deprecations.yml'."
    msg << "Please make sure that components are deprecated by setting the 'status :deprecated' within the component file"
    msg << "and update the 'lib/primer/deprercations.yml' with the appropriate configuration."
    msg.join(" ")
  end

  def deprecation_configuration_valid?(component_name)
    # For information on what configurations are valid / invalid, please see the
    # documentation in 'docs/contributors/deprecations.md'

    has_replacement = Primer::Deprecations.replacement?(component_name)
    is_correctable = Primer::Deprecations.correctable?(component_name)
    has_guide = Primer::Deprecations.guide?(component_name)

    # assume invalid until proven otherwise
    valid = false

    valid = true if has_replacement && is_correctable && has_guide
    valid = true if has_replacement && is_correctable && !has_guide
    valid = true if has_replacement && !is_correctable && has_guide
    valid = true if !has_replacement && !is_correctable && has_guide

    valid
  end

  def invalid_configuration_message(component_name)
    msg = []
    msg << "'#{component_name}' has an invalid deprecation configuration."
    msg << "Please check the documentation in 'docs/contributors/deprecations.md' for a list of what is valid / invalid,"
    msg << "and correct the configuration in the same file."
    msg.join(" ")
  end
end
