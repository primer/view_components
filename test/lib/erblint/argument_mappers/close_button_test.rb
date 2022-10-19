# frozen_string_literal: true

require "lib/erblint_test_case"

class ArgumentMappersCloseButtonTest < ErblintTestCase
  def test_returns_no_arguments_if_only_close_button
    @file = '<button class="close-button"><%= primer_octicon(:x) %></button>'
    args = ERBLint::Linters::ArgumentMappers::CloseButton.new(tags.first).to_args

    assert_empty args
  end

  def test_returns_type_argument
    Primer::Beta::CloseButton::TYPE_OPTIONS.each do |type|
      # button is the default, so it does not require a `type` argument
      next if type == :button

      @file = "<button class=\"close-button\" type=\"#{type}\"><%= primer_octicon(:x) %></button>"
      args = ERBLint::Linters::ArgumentMappers::CloseButton.new(tags.first).to_args

      assert_equal({ type: ":#{type}" }, args)
    end
  end

  def test_raises_if_type_is_not_supported
    @file = '<button class="close-button" type="some-type"><%= primer_octicon(:x) %></button>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::CloseButton.new(tags.first).to_args
    end

    assert_equal "CloseButton component does not support type \"some-type\"", err.message
  end
end
