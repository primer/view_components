# frozen_string_literal: true

require "test_helper"

class PrimerSelectMenuComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:modal) { "hello world" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/)
      end
    end
  end

  def test_renders_with_message
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:modal, message: "Goodness me") { "hello world" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/) do
          assert_selector("div.SelectMenu-message", text: /Goodness me/)
        end
      end
    end
  end

  def test_renders_with_header
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:header) { "A nice title" }
      component.slot(:modal) { "hello world" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("header.SelectMenu-header") do
          assert_selector("h3.SelectMenu-title", text: /A nice title/)
        end
        assert_selector("div.SelectMenu-list", text: /hello world/)
      end
    end
  end

  def test_renders_with_header_and_close_button
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:header) { "A nice title" }
      component.slot(:modal) { "hello world" }
      component.slot(:close_button) { "close me" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("header.SelectMenu-header") do
          assert_selector("h3.SelectMenu-title", text: /A nice title/)
          assert_selector("button.SelectMenu-closeButton", text: /close me/)
        end
        assert_selector("div.SelectMenu-list", text: /hello world/)
      end
    end
  end

  def test_renders_with_filter
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:filter) { "filter description" }
      component.slot(:modal) { "hello world" }
    end

    assert_selector("div.SelectMenu.SelectMenu--hasFilter") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/)
        assert_selector("form.SelectMenu-filter", text: /filter description/) do
          assert_selector("input.SelectMenu-input.form-control[placeholder='Filter']" \
            "[aria-label='Filter']")
        end
      end
    end
  end

  def test_renders_with_footer
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:modal) { "hello world" }
      component.slot(:footer) { "the end" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/)
        assert_selector("footer.SelectMenu-footer", text: /the end/)
      end
    end
  end

  def test_passes_along_other_arguments
    render_inline Primer::SelectMenuComponent.new(
      classes: "my-class",
      mr: 3,
      display: :block,
    ) do |component|
      component.slot(:header,
        tag: :div,
        classes: "my-header-class",
        mt: 1,
        title_tag: :h1,
        title_classes: "my-title-class",
      ) { "A nice title" }
      component.slot(:filter,
        tag: :div,
        input_classes: "my-input",
        classes: "my-filter",
        placeholder: "Search",
        "aria-label" => "A nice filter field",
        py: 1,
      ) { "filter description" }
      component.slot(:modal,
        classes: "my-modal-class",
        py: 2,
        color: :red,
        list_classes: "my-list-class",
        message: "Goodness me",
        message_classes: "my-message",
      ) { "hello world" }
      component.slot(:close_button,
        classes: "my-close-button",
        ml: 4,
        display: :inline_flex,
      ) { "close me" }
      component.slot(:footer,
        classes: "my-footer",
        tag: :div,
        mr: 3,
      ) { "the end" }
    end

    assert_selector("div.SelectMenu.SelectMenu--hasFilter.my-class.mr-3.d-block") do
      assert_selector("div.SelectMenu-modal.my-modal-class.py-2.text-red") do
        assert_selector("div.SelectMenu-header.my-header-class.mt-1") do
          assert_selector("h1.SelectMenu-title.my-title-class", text: /A nice title/)
          assert_selector("button.SelectMenu-closeButton.my-close-button.ml-4.d-inline-flex",
            text: /close me/)
        end
        assert_selector("div.SelectMenu-list.my-list-class", text: /hello world/) do
          assert_selector("div.SelectMenu-message.my-message", text: /Goodness me/)
        end
        assert_selector("div.SelectMenu-filter.my-filter.py-1", text: /filter description/) do
          assert_selector("input.SelectMenu-input.my-input[placeholder='Search']" \
            "[aria-label='A nice filter field']")
        end
        assert_selector("div.SelectMenu-footer.mr-3.my-footer", text: /the end/)
      end
    end
  end

  def test_omits_top_list_border_when_specified
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:modal, border: :omit_top) { "hello world" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list.border-top-0", text: /hello world/)
      end
    end
  end

  def test_omits_all_borders_when_specified
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:modal, border: :none) { "hello world" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list.SelectMenu-list--borderless",
          text: /hello world/)
      end
    end
  end

  def test_supports_right_alignment_of_menu
    render_inline Primer::SelectMenuComponent.new(align_right: true) do |component|
      component.slot(:modal) { "hello world" }
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
