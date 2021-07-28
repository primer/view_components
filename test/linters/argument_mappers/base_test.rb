# frozen_string_literal: true

require "linter_test_case"

class ArgumentMappersBaseTest < LinterTestCase
  def test_returns_no_arguments_no_attributes
    @file = "<div></div>"
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_empty args
  end

  def test_returns_known_system_arguments
    @file = '<div class="mr-1 p-3 d-none d-md-block anim-fade-in"></div>'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_args

    assert_equal({
                   mr: 1,
                   p: 3,
                   display: [:none, nil, :block],
                   animation: ":fade_in"
                 }, args)
  end

  def test_returns_known_system_arguments_as_string
    @file = '<div class="mr-1 p-3 d-none d-md-block anim-fade-in"></div>'
    args = ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_s

    assert_equal("mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in", args)
  end

  def test_raises_if_a_class_is_unknown
    @file = '<div class="mr-1 p-3 d-none d-md-block anim-fade-in custom"></div>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Base.new(tags.first).to_s
    end

    assert_equal("Cannot convert classes `custom`", err.message)
  end
end
