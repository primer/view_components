# frozen_string_literal: true

require "lib/test_helper"

class Primer::AttributesHelperTest < Minitest::Test
  include Primer::AttributesHelper

  def test_merge_aria
    component = Primer::Component.new

    hash1 = { "aria-disabled": "true", aria: { labelledby: "foo", describedby: "foo" }, foo: "foo" }
    hash2 = { aria: { invalid: "true", labelledby: "bar" }, "aria-label": "bar", bar: "bar", "aria-labelledby": "baz", "aria-describedby": nil }

    merged_arias = component.send(:merge_aria, hash1, hash2)

    assert_equal merged_arias, { disabled: "true", invalid: "true", labelledby: "foo bar baz", label: "bar", describedby: "foo" }

    # assert aria info removed from original hashes
    assert_equal hash1, { foo: "foo" }
    assert_equal hash2, { bar: "bar" }
  end

  def test_merge_data
    component = Primer::Component.new

    hash1 = { "data-foo": "true", data: { target: "foo" }, foo: "foo" }
    hash2 = { data: { bar: "false", target: "bar" }, "data-baz": "baz", bar: "bar", "data-target": "baz" }

    merged_data = component.send(:merge_data, hash1, hash2)

    assert_equal merged_data, { foo: "true", bar: "false", target: "foo bar baz", baz: "baz" }

    # assert aria info removed from original hashes
    assert_equal hash1, { foo: "foo" }
    assert_equal hash2, { bar: "bar" }
  end
end
