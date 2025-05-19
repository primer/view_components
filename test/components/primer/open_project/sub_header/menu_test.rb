# frozen_string_literal: true

require "components/test_helper"

class Primer::OpenProject::SubHeader::ButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::SubHeader::Menu.new(leading_icon: :star, label: "Hello")) do |menu|
      menu.with_item(label: "Subitem 1") do |item|
        item.with_leading_visual_icon(icon: :paste)
      end
      menu.with_item(label: "Subitem 2") do |item|
        item.with_leading_visual_icon(icon: :log)
      end
    end

    assert_selector(".Button-leadingVisual .octicon-star")

    assert_selector("ul[role=menu]") do
      assert_selector ".ActionListItem", text: "Subitem 1"
      assert_selector ".ActionListItem", text: "Subitem 2"
    end
  end

  def test_renders_an_icon_button
    render_inline(Primer::OpenProject::SubHeader::Menu.new(icon_only: true, leading_icon: :star, label: "Hello")) do |menu|
      menu.with_item(label: "Subitem 1") do |item|
        item.with_leading_visual_icon(icon: :paste)
      end
      menu.with_item(label: "Subitem 2") do |item|
        item.with_leading_visual_icon(icon: :log)
      end
    end

    assert_no_selector(".Button-leadingVisual .octicon-star")
    assert_selector(".Button--iconOnly .octicon-star")

    assert_selector("ul[role=menu]") do
      assert_selector ".ActionListItem", text: "Subitem 1"
      assert_selector ".ActionListItem", text: "Subitem 2"
    end
  end

  def test_does_not_render_without_icon
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::SubHeader::Menu.new(label: "Hello")) do |menu|
        menu.with_item(label: "Subitem 1") do |item|
          item.with_leading_visual_icon(icon: :paste)
        end
        menu.with_item(label: "Subitem 2") do |item|
          item.with_leading_visual_icon(icon: :log)
        end
      end
    end

    assert_equal "missing keyword: :leading_icon", err.message
  end

  def test_does_not_render_with_a_show_button_slot
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::SubHeader::Menu.new(leading_icon: :star, label: "Hello")) do |menu|
        menu.with_show_button { "Hello" }
        menu.with_item(label: "Subitem 1") do |item|
          item.with_leading_visual_icon(icon: :paste)
        end
        menu.with_item(label: "Subitem 2") do |item|
          item.with_leading_visual_icon(icon: :log)
        end
      end
    end

    assert_equal "Do not use the show_button slot within the SubHeader, as it is reserved. Instead provide a leading_icon within the subHeader button slot", err.message
  end

  def test_does_not_render_without_a_label
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::SubHeader::Menu.new(leading_icon: :star, label: "")) do |menu|
        menu.with_item(label: "Subitem 1") do |item|
          item.with_leading_visual_icon(icon: :paste)
        end
        menu.with_item(label: "Subitem 2") do |item|
          item.with_leading_visual_icon(icon: :log)
        end
      end
    end

    assert_equal "You need to provide a valid label.", err.message
  end
end
