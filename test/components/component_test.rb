# frozen_string_literal: true

require "test_helper"

class PrimerComponentInterfaceTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class TestComponent < Primer::Component
    deprecated_options_for :attribute, :deprecated

    def initialize(attribute:)
      @attribute = attribute
    end

    def call
      render(Primer::BoxComponent.new)
    end
  end

  class ErrorTestComponent < Primer::Component
    deprecated_options_for :attribute, :deprecated

    def initialize(attribute:)
    end

    def call
      render(Primer::BoxComponent.new)
    end
  end

  def test_raises_error_if_instance_variable_is_not_defined
    assert_raises Primer::InstanceVariableNotFound do
      render_inline(ErrorTestComponent.new(attribute: 1))
    end
  end

  def test_warns_of_deprecation_when_using_deprecated_value
    Primer::Deprecation.expects(:warn).with("option `deprecated` for `attribute` is deprecated and should not be used").once
    render_inline(TestComponent.new(attribute: :deprecated))
  end

  def test_does_not_warn_if_value_is_not_deprecated
    Primer::Deprecation.expects(:warn).never
    render_inline(TestComponent.new(attribute: :not_deprecated))
  end
end
