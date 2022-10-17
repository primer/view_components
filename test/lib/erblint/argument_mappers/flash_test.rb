# frozen_string_literal: true

require "lib/erblint_test_case"

class ArgumentMappersFlashTest < ErblintTestCase
  def test_returns_no_arguments_if_only_flash
    @file = '<div class="flash">flash</div>'
    args = ERBLint::Linters::ArgumentMappers::Flash.new(tags.first).to_args

    assert_empty args
  end

  def test_returns_full_argument
    @file = "<div class=\"flash-full\">flash</div>"
    args = ERBLint::Linters::ArgumentMappers::Flash.new(tags.first).to_args

    assert_equal({ full: true }, args)
  end

  def test_returns_scheme_argument
    Primer::Beta::Flash::SCHEME_MAPPINGS.each do |value, class_name|
      next if class_name.blank?

      @file = "<div class=\"#{class_name}\">flash</div>"
      args = ERBLint::Linters::ArgumentMappers::Flash.new(tags.first).to_args

      assert_equal({ scheme: ":#{value}" }, args)
    end
  end

  def test_raises_if_cannot_map_class
    @file = '<div class="text-fuzzy-waffle">flash</div>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Flash.new(tags.first).to_args
    end

    assert_equal "Cannot convert class text-fuzzy-waffle", err.message
  end

  def test_complex_case
    @file = '
      <div
        class="flash flash-full flash-warn mr-1 p-3 d-md-block d-none anim-fade-in"
      >flash</div>'

    args = ERBLint::Linters::ArgumentMappers::Flash.new(tags.first).to_args

    assert_equal({
                   scheme: ":warning",
                   full: true,
                   mr: 1,
                   p: 3,
                   display: [:none, nil, :block],
                   animation: ":fade_in"
                 }, args)
  end

  def test_returns_arguments_as_string
    @file = '<div class="flash flash-warn flash-full">flash</div>'
    args = ERBLint::Linters::ArgumentMappers::Flash.new(tags.first).to_s

    assert_equal "scheme: :warning, full: true", args
  end

  def test_returns_custom_classes_as_string
    @file = '<div class="flash custom-1 custom-2">flash</div>'
    args = ERBLint::Linters::ArgumentMappers::Flash.new(tags.first).to_args

    assert_equal({ classes: "\"custom-1 custom-2\"" }, args)
  end
end
