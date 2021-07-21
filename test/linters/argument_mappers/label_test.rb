# frozen_string_literal: true

require "linter_test_case"

class ArgumentMappersLabelTest < LinterTestCase
  def test_returns_no_arguments_if_only_label
    @file = '<span class="Label">Label</span>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_empty args
  end

  def test_returns_aria_arguments_as_string_symbols
    @file = '<span aria-label="label" aria-disabled="true" aria-boolean>Label</span>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({
                   '"aria-label"' => '"label"',
                   '"aria-disabled"' => '"true"',
                   '"aria-boolean"' => '""'
                 }, args)
  end

  def test_returns_data_arguments_as_string_symbols
    @file = '<span data-action="click" data-pjax>Label</span>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({
                   '"data-action"' => '"click"',
                   '"data-pjax"' => '""'
                 }, args)
  end

  def test_returns_scheme_argument
    Primer::LabelComponent::SCHEME_MAPPINGS.each do |value, class_name|
      next if class_name.blank?

      @file = "<span class=\"#{class_name}\">Label</span>"
      args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

      assert_equal({ scheme: ":#{value}" }, args)
    end
  end

  def test_returns_variant_argument
    Primer::LabelComponent::VARIANT_MAPPINGS.each do |value, class_name|
      next if class_name.blank?

      @file = "<span class=\"#{class_name}\">Label</span>"
      args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

      assert_equal({ variant: ":#{value}" }, args)
    end
  end

  def test_returns_tag_argument
    Primer::LabelComponent::TAG_OPTIONS.each do |tag|
      # span is the default, so it does not require a `tag` argument
      next if tag == :span

      @file = "<#{tag} class=\"Label\">Label</#{tag}>"
      args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

      assert_equal({ tag: ":#{tag}" }, args)
    end
  end

  def test_raises_if_cannot_map_class
    @file = '<span class="some-class">Label</span>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args
    end

    assert_equal "Cannot convert class \"some-class\"", err.message
  end

  def test_raises_if_cannot_map_attribute
    @file = '<span some-attribute="some-value">Label</span>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args
    end

    assert_equal "Cannot convert attribute \"some-attribute\"", err.message
  end

  def test_converts_data_test_selector
    @file = '<span data-test-selector="some-selector">Label</span>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({ test_selector: '"some-selector"' }, args)
  end

  def test_converts_erb_test_selector_call
    @file = '<span class="Label" <%= test_selector("some-selector") %>>Label</span>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({ test_selector: '"some-selector"' }, args)
  end

  def test_raises_if_unsupported_erb_block
    @file = '<span class="Label" <%= some_method("some-selector") %>>Label</span>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args
    end

    assert_equal "Cannot convert erb block", err.message
  end

  def test_complex_case
    @file = '
      <span
        class="Label Label--primary Label--large"
        aria-label="some label"
        data-pjax
        data-click="click"
        <%= test_selector("some_selector") %>
      >Label</span>'

    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({
                   :scheme => ":primary",
                   :variant => ":large",
                   '"aria-label"' => '"some label"',
                   '"data-pjax"' => '""',
                   '"data-click"' => '"click"',
                   :test_selector => '"some_selector"',
                 }, args)
  end

  def test_returns_arguments_as_string
    @file = '<div class="Label Label--primary" aria-label="some label">Link</div>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_s

    assert_equal 'tag: :div, scheme: :primary, "aria-label": "some label"', args
  end
end
