# frozen_string_literal: true

require "test_helper"

class PrimerUnderlineNavComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_align_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::UnderlineNavComponent.new(align: :foo)) do |component|
        component.with(:body) do
          "Body content"
        end
        component.with(:actions) do
          "Actions content"
        end
      end
    end

    refute_selector(".UnderlineNav--right")
  end

  def test_adds_underline_nav_right_when_align_right_is_set
    render_inline(Primer::UnderlineNavComponent.new(align: :right)) do |component|
      component.with(:body) do
        "Body content"
      end
      component.with(:actions) do
        "Actions content"
      end
    end

    assert_selector(".UnderlineNav--right")
  end

  def test_puts_actions_first_if_align_right_and_actions_exist
    render_inline(Primer::UnderlineNavComponent.new(align: :right)) do |component|
      component.with(:body) do
        "Body content"
      end
      component.with(:actions) do
        "Actions content"
      end
    end

    assert_selector(".UnderlineNav > .UnderlineNav-body:last-child")
  end
end
