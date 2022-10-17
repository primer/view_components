# frozen_string_literal: true

require "lib/erblint_test_case"

class ArgumentMappersLabelTest < ErblintTestCase
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

  def test_returns_inline_argument
    @file = "<span class=\"Label--inline\">Label</span>"
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({ inline: true }, args)
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
    @file = '<span class="text-fuzzy-waffle">Label</span>'
    err = assert_raises ERBLint::Linters::ArgumentMappers::ConversionError do
      ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args
    end

    assert_equal "Cannot convert class text-fuzzy-waffle", err.message
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
                   size: ":large",
                   title: '"some title"',
                   mr: 1,
                   p: 3,
                   display: [:none, nil, :block],
                   animation: ":fade_in"
                 }, args)
  end

  def test_returns_arguments_as_string
    @file = '<div class="Label Label--primary">Label</div>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_s

    assert_equal "tag: :div, scheme: :primary", args
  end

  def test_converts_basic_interpolation
    @file = '<span class="Label" title="<%= some_call %>">Label</span>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({ title: "some_call" }, args)
  end

  def test_converts_interpolation_with_string
    @file = '<span class="Label" title="string-<%= some_call %>">Label</span>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({ title: "\"string-\#{ some_call }\"" }, args)
  end

  def test_converts_multiple_interpolations
    @file = '<span class="Label" title="string-<%= some_call %><%= other_call %>-more-<%= another_call %>">Label</span>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({ title: "\"string-\#{ some_call }\#{ other_call }-more-\#{ another_call }\"" }, args)
  end

  def test_returns_custom_classes_as_string
    @file = '<span class="Label custom-1 custom-2">Label</span>'
    args = ERBLint::Linters::ArgumentMappers::Label.new(tags.first).to_args

    assert_equal({ classes: "\"custom-1 custom-2\"" }, args)
  end
end
