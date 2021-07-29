# frozen_string_literal: true

require "linter_test_case"

class ArgumentMappersLabelTest < LinterTestCase
  def test_returns_no_arguments_if_only_label
    @file = '<span class="Label">Label</span>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_empty args
  end

  def test_returns_title_argument
    @file = "<span title=\"some title\">Label</span>"
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({ title: '"some title"' }, args)
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

  def test_complex_case
    @file = '
      <span
        class="Label Label--primary Label--large mr-1 p-3 d-md-block d-none anim-fade-in"
        title="some title"
      >Label</span>'

    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({
                   scheme: ":primary",
                   variant: ":large",
                   title: '"some title"',
                   mr: 1,
                   p: 3,
                   display: [:none, nil, :block],
                   animation: ":fade_in"
                 }, args)
  end

  def test_returns_arguments_as_string
    @file = '<div class="Label Label--primary">Link</div>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_s

    assert_equal "tag: :div, scheme: :primary", args
  end

  def test_raises_if_title_has_erb_value
    @file = '<span class="Label" title="<%= some_call %>">Label</span>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args
    end

    assert_equal "Cannot convert attribute \"title\" because its value contains an erb block", err.message
  end
end
