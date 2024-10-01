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

  # iterate over all responsive props and assert that they are rendered
  def test_renders_responsive_props
    render_inline(Primer::Box.new) do
      "content"
    end

    assert_selector("div")
  end


  Primer::Alpha::Stack::ResponsiveArg.descendants.each do |descendant|
    descendant::OPTIONS.each do |option|
      next unless option
      define_method("test_renders_responsive_prop_#{descendant.arg_name}_with_#{option}_option") do
        render_inline(Primer::Alpha::Stack.new(descendant.arg_name => [option]*(5))) do
          "content"
        end

        assert_selector("div[data-#{descendant.arg_name.to_s.dasherize}=\"#{option.to_s.dasherize}\"]")
        assert_selector("div[data-#{descendant.arg_name.to_s.dasherize}-narrow=\"#{option.to_s.dasherize}\"]")
        assert_selector("div[data-#{descendant.arg_name.to_s.dasherize}-regular=\"#{option.to_s.dasherize}\"]")
        assert_selector("div[data-#{descendant.arg_name.to_s.dasherize}-wide=\"#{option.to_s.dasherize}\"]")
      end
    end
  end

  # iterate over
  def test_renders_static_props
  end

  def test_status
    assert_component_state(Primer::Alpha::Stack, :alpha)
  end
end
