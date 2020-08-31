# frozen_string_literal: true

require "test_helper"

class PrimerComponentInterfaceTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class TestComponent < Primer::Component
    deprecated_options_for :variant, :deprecated

    def initialize(variant:)
      @variant = variant
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
end
