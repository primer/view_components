# frozen_string_literal: true

require "lib/erblint_test_case"

class ArgumentMappersButtonTest < ErblintTestCase
  def test_returns_no_arguments_if_only_btn
    @file = '<button class="btn">Button</button>'
    args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

    assert_empty args
  end

  def test_returns_disabled_argument_as_boolean
    @file = "<button disabled>Button</button>"
    args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

    assert_equal({ disabled: true }, args)
  end

  def test_returns_block_argument
    @file = '<button class="btn-block">Button</button>'
    args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

    assert_equal({ block: true }, args)
  end

  def test_returns_group_item_argument
    @file = '<button class="BtnGroup-item">Button</button>'
    args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

    assert_equal({ group_item: true }, args)
  end

  def test_returns_scheme_argument
    Primer::ButtonComponent::SCHEME_MAPPINGS.each do |value, class_name|
      next if class_name.blank?

      @file = "<button class=\"#{class_name}\">Button</button>"
      args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

      assert_equal({ scheme: ":#{value}" }, args)
    end
  end

  def test_returns_size_argument
    Primer::ButtonComponent::SIZE_MAPPINGS.each do |value, class_name|
      next if class_name.blank?

      @file = "<button class=\"#{class_name}\">Button</button>"
      args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

      assert_equal({ size: ":#{value}" }, args)
    end
  end

  def test_returns_tag_argument
    Primer::Beta::BaseButton::TAG_OPTIONS.each do |tag|
      # button is the default, so it does not require a `tag` argument
      next if tag == :button

      @file = "<#{tag} class=\"btn\">Button</#{tag}>"
      args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

      assert_equal({ tag: ":#{tag}" }, args)
    end
  end

  def test_returns_type_argument
    Primer::Beta::BaseButton::TYPE_OPTIONS.each do |type|
      # button is the default, so it does not require a `type` argument
      next if type == :button

      @file = "<button class=\"btn\" type=\"#{type}\">Button</button>"
      args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

      assert_equal({ type: ":#{type}" }, args)
    end
  end

  def test_raises_if_type_is_not_supported
    @file = '<button class="btn" type="some-type">Button</button>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args
    end

    assert_equal "Button component does not support type \"some-type\"", err.message
  end

  def test_raises_if_cannot_map_class
    @file = '<button class="text-fuzzy-waffle">Button</button>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args
    end

    assert_equal "Cannot convert class text-fuzzy-waffle", err.message
  end

  def test_raises_if_cannot_map_attribute
    @file = '<button some-attribute="some-value">Button</button>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args
    end

    assert_equal "Cannot convert attribute \"some-attribute\"", err.message
  end

  def test_converts_erb_test_selector_call
    @file = '<button class="btn" <%= test_selector("some-selector") %>>Button</button>'
    args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

    assert_equal({ test_selector: '"some-selector"' }, args)
  end

  def test_raises_if_unsupported_erb_block
    @file = '<button class="btn" <%= some_method("some-selector") %>>Button</button>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args
    end

    assert_equal "Cannot convert erb block", err.message
  end

  def test_with_system_arguments
    @file = '
      <button
        class="btn btn-primary btn-sm btn-block BtnGroup-item mr-1 p-3 d-md-block d-none anim-fade-in"
        disabled
        type="submit"
      >Button</button>'

    args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

    assert_equal({
                   scheme: ":primary",
                   size: ":small",
                   block: true,
                   group_item: true,
                   mr: 1,
                   p: 3,
                   display: [:none, nil, :block],
                   animation: ":fade_in",
                   disabled: true,
                   type: ":submit"
                 }, args)
  end

  def test_returns_arguments_as_string
    @file = '<a class="btn btn-primary">Link</a>'
    args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_s

    assert_equal "tag: :a, scheme: :primary", args
  end

  def test_returns_custom_classes_as_string
    @file = '<button class="btn custom-1 custom-2">button</button>'
    args = ERBLint::Linters::ArgumentMappers::Button.new(tags.first).to_args

    assert_equal({ classes: "\"custom-1 custom-2\"" }, args)
  end
end
