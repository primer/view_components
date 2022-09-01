# frozen_string_literal: true

require "test_helper"

class ArgumentsDefinitionHelperTest < Minitest::Test
  include Primer::Responsive::HtmlAttributesHelper

  # this list should be used ignoring prefixed attrs
  ALLOWED_ATTRS = Primer::Responsive::HtmlAttributesHelper::ALLOWED_GLOBAL_ATTRIBUTES

  def test_validate_html_attributes_raises_error_if_not_allowed_attribute_is_present
    # arrange
    attributes = {
      invalid_attr_attribute: "dummy value"
    }

    # act / assert
    assert_raises(Primer::Responsive::HtmlAttributesHelper::InvalidHtmlAttributeError) do
      validate_html_attributes(attributes)
    end
  end

  def test_validate_html_attributes_uses_default_allowed_global_attributes_and_doesnt_raise_if_only_allowed_attrs_are_used
    # arrange
    attributes = {}
    # - add all non prefixed allowed attrs
    ALLOWED_ATTRS.each { |attr| attributes[attr] = "dummy value" unless attr.to_s.end_with? "*" }
    # - add a single prefixes attr to make sure it works
    attributes[:"data-custom-attr"] = "dummy value"

    err = nil
    begin
      # act
      validate_html_attributes(attributes)
    rescue Primer::Responsive::HtmlAttributesHelper::InvalidHtmlAttributeError => e
      err = e
    end

    # assert
    assert_nil(err, "No exception can be raised if the attributes are included in the allowed globals")
  end

  def test_strict_validate_html_attributes_doesnt_include_predefined_global_when_validating_given_attributes
    # arrange
    attribute_key = ALLOWED_ATTRS.find { |attr| !attr.to_s.end_with?("*") }
    attributes = { attribute_key => "dummy value" }
    allowed_attributes = [:allowed_attr]

    # act / assert
    assert_raises(Primer::Responsive::HtmlAttributesHelper::InvalidHtmlAttributeError) do
      strict_validate_html_attributes(attributes, allowed_attributes: allowed_attributes)
    end
  end

  def test_strict_validate_html_attributes_accepts_attributes_defined_in_allowed_attrs_or_allowed_prefixes
    # arrange
    attributes = {
      allowed_attr: "dummy value",
      "data-test": "dummy value"
    }
    allowed_attrs = [:allowed_attr]
    allowed_prefixes = [:"data-"]

    err = nil
    begin
      # act
      strict_validate_html_attributes(
        attributes,
        allowed_attributes: allowed_attrs,
        allowed_attribute_prefixes: allowed_prefixes
      )
    rescue Primer::Responsive::HtmlAttributesHelper::InvalidHtmlAttributeError => e
      err = e
    end

    # assert
    assert_nil(err, "No exception can be raised if the attributes given are included in the allowed or prefixes attributes lists")
  end

  def test_sanitize_html_attributes_return_hash_with_only_allowed_attributes
    # arrange
    attributes = {
      # invalid attrs
      invalid_attr: "dummy value",
      another_invalid_attr: "dummy value",

      # valid attrs
      id: "dummy value",
      custom_allowed_attr: "dummy value"
    }
    additional_allowed_attrs = [:custom_allowed_attr]
    expected_attributes = [:id, :custom_allowed_attr]

    # act
    sanitized_attrs = sanitize_html_attributes(attributes, additional_allowed_attributes: additional_allowed_attrs)

    # assert
    sanitized_attrs.each do |attr, value|
      assert(expected_attributes.include?(attr), "Sanitization allowed invalid attribute `#{attr}`` in sanitized output")
      assert_equal(attributes[attr], value, "Sanitized value must be the same after sanitization of attributes")
    end
  end

  def test_strict_sanitize_html_attributes_doesnt_include_global_allowed_attributes_and_only_allow_specified_allowed_attributes
    # arrange
    attributes = {
      # invalid global attributes
      id: "dummy id",
      lang: "dummy lang",

      # valid attrs
      custom_allowed_attr: "dummy value",
      tabindex: "dummy index"
    }
    allowed_attrs = [:custom_allowed_attr, :tabindex, :extra_allowed_attr]
    expected_attributes = [:custom_allowed_attr, :tabindex]

    # act
    sanitized_attrs = strict_sanitize_html_attributes(attributes, allowed_attributes: allowed_attrs)

    # assert
    sanitized_attrs.each do |attr, value|
      assert(expected_attributes.include?(attr), "Sanitization allowed invalid attribute `#{attr}`` in sanitized output")
      assert_equal(attributes[attr], value, "Sanitized value must be the same after sanitization of attributes")
    end
  end
end
