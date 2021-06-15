# frozen_string_literal: true

require "test_helper"

class PrimerClassifyUtilitiesTest < Minitest::Test
  def test_supported_key
    assert Primer::Classify::Utilities.supported_key?(:m)
    refute Primer::Classify::Utilities.supported_key?(:flex)
  end

  def test_supported_value
    assert Primer::Classify::Utilities.supported_value?(:m, 1)
    refute Primer::Classify::Utilities.supported_value?(:m, :foo)
  end

  def test_mappings
    assert_equal [:left, :right, :none], Primer::Classify::Utilities.mappings(:float)
    refute_includes Primer::Classify::Utilities.mappings(:float), :sm
  end

  def test_responsive
    assert Primer::Classify::Utilities.responsive?(:mr, 0)
    refute Primer::Classify::Utilities.responsive?(:hide, :sm)
  end

  def test_classname_returns_empty_string_when_incorrect_value_in_production
    Rails.stub(:env, ActiveSupport::StringInquirer.new("production")) do
      assert_equal "mr-1", Primer::Classify::Utilities.classname(:mr, 1)
      assert_equal "", Primer::Classify::Utilities.classname(:mr, :foo)
    end
  end

  def test_classes_to_hash
    assert_equal({ mr: 1, mb: 2, classes: "foo" }, Primer::Classify::Utilities.classes_to_hash("mr-1 mb-2 foo"))
    assert_equal({ classes: "foo" }, Primer::Classify::Utilities.classes_to_hash("foo"))
    assert_equal({ mx: :auto }, Primer::Classify::Utilities.classes_to_hash("mx-auto"))
    assert_equal({ mr: [1, 2], classes: "baz bin" }, Primer::Classify::Utilities.classes_to_hash("mr-1 mr-sm-2 baz bin"))
    assert_equal({ mr: [1, nil, 2], classes: "foo bar" }, Primer::Classify::Utilities.classes_to_hash("mr-1 mr-md-2 foo bar"))
  end

  def test_classes_to_hash_returns_classes_when_run_in_production
    Rails.stub(:env, ActiveSupport::StringInquirer.new("production")) do
      assert_equal({ classes: "mr-1 mr-md-2 foo bar" }, Primer::Classify::Utilities.classes_to_hash("mr-1 mr-md-2 foo bar"))
    end
  end
end
