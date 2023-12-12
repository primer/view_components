# frozen_string_literal: true

require "lib/test_helper"

class PrimerClassifyUtilitiesTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_supported_key
    assert Primer::Classify::Utilities.supported_key?(:m)
    refute Primer::Classify::Utilities.supported_key?(:foo)
  end

  def test_supported_value
    assert Primer::Classify::Utilities.supported_value?(:m, 1)
    refute Primer::Classify::Utilities.supported_value?(:m, :foo)
  end

  def test_supported_selector
    assert Primer::Classify::Utilities.supported_selector?("m-1")
    refute Primer::Classify::Utilities.supported_selector?("foo")
  end

  def test_supported_selector_returns_nil_when_validation_disabled
    with_validate_class_names(false) do
      refute Primer::Classify::Utilities.supported_selector?("m-1")
      refute Primer::Classify::Utilities.supported_selector?("foo")
    end
  end

  def test_mappings
    assert_equal [:left, :right, :none], Primer::Classify::Utilities.mappings(:float)
    refute_includes Primer::Classify::Utilities.mappings(:float), :sm
  end

  def test_responsive
    assert Primer::Classify::Utilities.responsive?(:mr, 0)
    refute Primer::Classify::Utilities.responsive?(:hide, :sm)
  end

  def test_classname_returns_key_value_when_incorrect_value_and_validation_disabled
    with_validate_class_names(false) do
      assert_equal "mr-1", Primer::Classify::Utilities.classname(:mr, 1)
      assert_equal "mr-foo", Primer::Classify::Utilities.classname(:mr, :foo)
      assert_equal "color-yellow-0", Primer::Classify::Utilities.classname(:color, :yellow_0)
    end
  end

  def test_classname_errors_on_unsupported_key
    error = assert_raises(ArgumentError) do
      Primer::Classify::Utilities.classname(:foo, :bar)
    end

    assert_equal "foo is not a valid Primer utility key", error.message
  end

  def test_classname_empty_on_unsupported_key_when_validation_disabled
    with_validate_class_names(false) do
      assert_equal "", Primer::Classify::Utilities.classname(:foo, :bar)
    end
  end

  def test_classname_errors_on_non_responsive_utility
    error = assert_raises(ArgumentError) do
      Primer::Classify::Utilities.classname(:w, :fit, :sm)
    end

    assert_equal "w does not support responsive values", error.message
  end

  def test_classname_empty_on_non_responsive_utility_when_validation_disabled
    with_validate_class_names(false) do
      assert_equal "", Primer::Classify::Utilities.classname(:w, :fit, :sm)
    end
  end

  def test_classname_errors_on_unsupported_value
    error = assert_raises(ArgumentError) do
      Primer::Classify::Utilities.classname(:w, :foo)
    end

    assert_includes error.message, "foo is not a valid value for :w"
  end

  def test_nil_classname_when_argument_value_is_false
    refute Primer::Classify::Utilities.classname(:clearfix, false)
  end

  def test_classname_on_unsupported_value_when_validation_disabled
    with_validate_class_names(false) do
      assert_equal "w-foo", Primer::Classify::Utilities.classname(:w, :foo)
    end
  end

  def test_classes_to_hash
    assert_equal({ mr: 1, mb: 2, classes: "foo" }, Primer::Classify::Utilities.classes_to_hash("mr-1 mb-2 foo"))
    assert_equal({ classes: "foo" }, Primer::Classify::Utilities.classes_to_hash("foo"))
    assert_equal({ mx: :auto }, Primer::Classify::Utilities.classes_to_hash("mx-auto"))
    assert_equal({ mr: [1, 2], classes: "baz bin" }, Primer::Classify::Utilities.classes_to_hash("mr-1 mr-sm-2 baz bin"))
    assert_equal({ mr: [1, nil, 2], classes: "foo bar" }, Primer::Classify::Utilities.classes_to_hash("mr-1 mr-md-2 foo bar"))
    assert_equal({ color: :muted }, Primer::Classify::Utilities.classes_to_hash("color-fg-muted"))
  end

  def test_classes_to_args
    assert_equal('mr: 1, mb: 2, classes: "foo"', Primer::Classify::Utilities.classes_to_args("mr-1 mb-2 foo"))
    assert_equal('classes: "foo"', Primer::Classify::Utilities.classes_to_args("foo"))
    assert_equal("mx: :auto", Primer::Classify::Utilities.classes_to_args("mx-auto"))
    assert_equal("font_size: 3, border_radius: 0", Primer::Classify::Utilities.classes_to_args("f3 rounded-0"))
    assert_equal('mr: [1, 2], classes: "baz bin"', Primer::Classify::Utilities.classes_to_args("mr-1 mr-sm-2 baz bin"))
    assert_equal('mr: [1, nil, 2], classes: "foo bar"', Primer::Classify::Utilities.classes_to_args("mr-1 mr-md-2 foo bar"))
  end

  def test_hash_to_args
    assert_equal('mr: 1, mb: 2, classes: "foo"', Primer::Classify::Utilities.hash_to_args({ mr: 1, mb: 2, classes: "foo" }))
    assert_equal('classes: "foo"', Primer::Classify::Utilities.hash_to_args({ classes: "foo" }))
    assert_equal("mx: :auto", Primer::Classify::Utilities.hash_to_args({ mx: :auto }))
    assert_equal('mr: [1, 2], classes: "baz bin"', Primer::Classify::Utilities.hash_to_args({ mr: [1, 2], classes: "baz bin" }))
    assert_equal('mr: [1, nil, 2], classes: "foo bar"', Primer::Classify::Utilities.hash_to_args({ mr: [1, nil, 2], classes: "foo bar" }))
  end

  def test_classes_to_hash_returns_classes_when_run_with_validation_disabled
    with_validate_class_names(false) do
      assert_equal({ classes: "mr-1 mr-md-2 foo bar" }, Primer::Classify::Utilities.classes_to_hash("mr-1 mr-md-2 foo bar"))
    end
  end
end
