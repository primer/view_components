# frozen_string_literal: true

require "components/test_helper"

class PrimerConditionalWrapperTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_wraps_content_when_condition_is_true
    render_inline(Primer::ConditionalWrapper.new(condition: true, tag: :div, classes: "foo")) do |component|
      component.content_tag(:span, class: "inner") { "Some content" }
    end

    assert_selector ".foo .inner", text: "Some content"
  end

  def test_does_not_wrap_when_condition_is_false
    render_inline(Primer::ConditionalWrapper.new(condition: false, tag: :div, classes: "foo")) do |component|
      component.content_tag(:span, class: "inner") { "Some content" }
    end

    refute_selector ".foo .inner"
    assert_selector ".inner", text: "Some content"
  end
end
