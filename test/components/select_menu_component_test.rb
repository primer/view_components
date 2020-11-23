# frozen_string_literal: true

require "test_helper"

class PrimerSelectMenuComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:modal) do
        "hello world"
      end
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/)
      end
    end
  end

  def test_passes_along_other_arguments
    render_inline Primer::SelectMenuComponent.new(
      classes: "my-class",
      mr: 3,
      display: :block,
    ) do |component|
      component.slot(:modal,
        classes: "my-modal-class",
        py: 2,
        color: :red,
        list_classes: "my-list-class"
      ) do
        "hello world"
      end
    end

    assert_selector("div.SelectMenu.my-class.mr-3.d-block") do
      assert_selector("div.SelectMenu-modal.my-modal-class.py-2.text-red") do
        assert_selector("div.SelectMenu-list.my-list-class", text: /hello world/)
      end
    end
  end

  def test_omits_top_list_border_when_specified
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:modal, omit_top_border: true) do
        "hello world"
      end
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list.border-top-0", text: /hello world/)
      end
    end
  end

  def test_supports_right_alignment_of_menu
    render_inline Primer::SelectMenuComponent.new(align_right: true) do |component|
      component.slot(:modal) do
        "hello world"
      end
    end

    assert_selector("div.SelectMenu.right-0") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/)
      end
    end
  end

  def test_prevents_rendering_without_modal
    render_inline(Primer::SelectMenuComponent.new)
    refute_selector("div")
  end
end
