# frozen_string_literal: true

require "components/test_helper"

class PrimerStackTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Alpha::Stack.new) do
      "content"
    end

    assert_text("content")
  end

  def test_attaches_stack_class
    render_inline(Primer::Alpha::Stack.new) do
      "content"
    end

    assert_selector(".Stack")
  end

  def test_uses_div_as_default_tag
    render_inline(Primer::Alpha::Stack.new) do
      "content"
    end

    assert_selector("div.Stack")
  end

  def test_allows_customizing_tag
    render_inline(Primer::Alpha::Stack.new(tag: :a)) do
      "content"
    end

    assert_selector("a.Stack")
  end

  # Responsive arg tests, i.e. Stack.new(justify: [:center, :center, ...])
  Primer::ResponsiveArg.descendants.each do |descendant|
    # TODO: fix this (StackItem's arg)
    next unless descendant.arg_name != :grow
    descendant::OPTIONS.each do |option|
      next unless option

      define_method("test_renders_responsive_arg_#{descendant.arg_name}_with_#{option}_option") do
        # create a Stack for rendering, eg. Stack.new(:justify, [five-element responsive values array])
        stack = Primer::Alpha::Stack.new(
          descendant.arg_name => [option] * Primer::ResponsiveArg::BREAKPOINTS.size
        )

        render_inline(stack) { "content" }

        dasherized_arg = descendant.arg_name.to_s.dasherize
        dasherized_option = option.to_s.dasherize

        assert_selector(".Stack[data-#{dasherized_arg}=\"#{dasherized_option}\"]")
        assert_selector(".Stack[data-#{dasherized_arg}-narrow=\"#{dasherized_option}\"]")
        assert_selector(".Stack[data-#{dasherized_arg}-regular=\"#{dasherized_option}\"]")
        assert_selector(".Stack[data-#{dasherized_arg}-wide=\"#{dasherized_option}\"]")
      end
    end
  end

  # Static arg tests, i.e. Stack.new(justify: :center)
  Primer::Alpha::Stack::ARG_CLASSES.each do |arg_class|
    arg_class::OPTIONS.each do |option|
      next unless option

      define_method("test_renders_static_arg_#{arg_class.arg_name}_with_#{option}_option") do
        render_inline(Primer::Alpha::Stack.new(arg_class.arg_name => option)) do
          "content"
        end

        assert_selector(".Stack[data-#{arg_class.arg_name.to_s.dasherize}=\"#{option.to_s.dasherize}\"]")
      end
    end
  end

  Primer::Alpha::Stack::ARG_CLASSES.each do |arg_class|
    next unless arg_class::DEFAULT

    define_method("test_renders_static_arg_#{arg_class.arg_name}_with_default_option") do
      render_inline(Primer::Alpha::Stack.new) do
        "content"
      end

      assert_selector(".Stack[data-#{arg_class.arg_name.to_s.dasherize}=\"#{arg_class::DEFAULT.to_s.dasherize}\"]")
    end
  end

  def test_status
    assert_component_state(Primer::Alpha::Stack, :alpha)
  end
end
