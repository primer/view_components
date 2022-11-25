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

  # ensure all components that has `status: :deprecated` are listed in the
  # component deprecations configuration file
  Primer::Component.descendants.each do |component_class|
    class_test_name = component_class.name.downcase.gsub("::", "_")
    define_method("test_ensure_#{class_test_name}_is_properly_deprecated") do
      if component_class.deprecated? # rubocop:disable Style/IfUnlessModifier
        assert @deprecated_components.include?(component_class.name), missing_deprecation_message(component_class)
      end
    end
  end

  private

  def missing_deprecation_message(component_class)
    "PVC Component '#{component_class.name}' has a `status` of `:deprected`, but is not listed in the deprecations.yml file. Please update the deprecations configuration in `lib/primer/deprecations.yml`"
  end
end
