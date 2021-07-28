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
end
