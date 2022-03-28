# frozen_string_literal: true

require "test_helper"

class PrimerAlphaNavigationListTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_top_level_items
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |_item|
        "Item"
      end
    end

    assert_selector("ul.ActionList") do
      assert_selector("a.ActionList-content") do
        assert_selector("span.ActionList-item-label", text: "Item")
      end
    end
  end

  def test_aria_label_for_nav
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(item_ids: :item, href: "/item") do |_item|
        "Item"
      end
    end

    assert_selector("nav[aria-label='Items']")
  end

  def test_missing_nav_aria_label_raises_error
    error = assert_raises ArgumentError do
      render_inline(Primer::Alpha::NavigationList.new)
    end

    assert_match(/an aria-label is required/, error.message)
  end

  def test_item_with_leading_icon_visual
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |item|
        item.leading_visual_icon(icon: :"mark-github")
        "Item"
      end
    end

    assert_selector("ul.ActionList") do
      assert_selector("a.ActionList-content.ActionList-content--visual16") do
        assert_selector(".ActionList-item-label", text: "Item")
        assert_selector(".ActionList-item-visual.ActionList-item-visual--leading svg.octicon-mark-github")
      end
    end
  end

  def test_item_with_leading_avatar_visual
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |item|
        item.leading_visual_avatar(src: "https://github.com/github.png", alt: "GitHub")
        "Item"
      end
    end

    assert_selector("ul.ActionList") do
      assert_selector("a.ActionList-content.ActionList-content--visual16") do
        assert_selector(".ActionList-item-label", text: "Item")
        assert_selector(".ActionList-item-visual.ActionList-item-visual--leading img.avatar[src='https://github.com/github.png'][size=16]")
      end
    end
  end

  def test_item_with_leading_svg_visual
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |item|
        item.leading_visual_svg(alt: "Circle") do
          '<circle cx="8" cy="8" r="8" fill="green" />'.html_safe
        end
        "Item"
      end
    end

    assert_selector("ul.ActionList") do
      assert_selector("a.ActionList-content.ActionList-content--visual16") do
        assert_selector(".ActionList-item-label", text: "Item")
        assert_selector(".ActionList-item-visual.ActionList-item-visual--leading svg circle")
      end
    end
  end

  def test_item_with_trailing_icon_visual
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |item|
        item.trailing_visual_icon(icon: :"mark-github")
        "Item"
      end
    end

    assert_selector("ul.ActionList") do
      assert_selector("a.ActionList-content.ActionList-content--visual16") do
        assert_selector(".ActionList-item-label", text: "Item")
        assert_selector(".ActionList-item-visual.ActionList-item-visual--trailing svg.octicon-mark-github")
      end
    end
  end

  def test_item_with_trailing_label_visual
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |item|
        item.trailing_visual_label(label: "Label") { "Label" }
        "Item"
      end
    end

    assert_selector("ul.ActionList") do
      assert_selector("a.ActionList-content.ActionList-content--visual16") do
        assert_selector(".ActionList-item-label", text: "Item")
        assert_selector(".ActionList-item-visual.ActionList-item-visual--trailing span.Label", text: "Label")
      end
    end
  end

  def test_item_with_trailing_counter_visual
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |item|
        item.trailing_visual_counter(count: 25)
        "Item"
      end
    end

    assert_selector("ul.ActionList") do
      assert_selector("a.ActionList-content.ActionList-content--visual16") do
        assert_selector(".ActionList-item-label", text: "Item")
        assert_selector(".ActionList-item-visual.ActionList-item-visual--trailing span.Counter", text: "25")
      end
    end
  end

  def test_selected_item
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" }, selected_item_id: :item2)) do |component|
      component.item(selected_by_ids: :item1, href: "/item1") { "Item 1" }
      component.item(selected_by_ids: :item2, href: "/item2") { "Item 2" }
      component.item(selected_by_ids: :item3, href: "/item3") { "Item 3" }
    end

    assert_selector(".ActionList-item.ActionList-item--navActive", text: "Item 2") do
      assert_selector(".ActionList-content[aria-current='page']")
    end
  end

  def test_disabled_item
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item1, href: "/item1") { "Item 1" }
      component.item(selected_by_ids: :item2, href: "/item2", disabled: true) { "Item 2" }
      component.item(selected_by_ids: :item3, href: "/item3") { "Item 3" }
    end

    assert_selector("a.ActionList-content", text: "Item 1")
    assert_selector("span.ActionList-content", text: "Item 2")
    assert_selector("a.ActionList-content", text: "Item 3")
  end

  def test_aria_label_for_section
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.section(aria: { label: "Section" }) do |section|
        section.item(item_ids: :item, href: "/item") do |_item|
          "Item"
        end
      end
    end

    assert_selector(".ActionList") do
      assert_selector("ul[aria-label='Section']")
    end
  end

  def test_missing_aria_label_for_section_raises_error
    error = assert_raises ArgumentError do
      render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
        component.section do |section|
          section.item(item_ids: :item, href: "/item") do |_item|
            "Item"
          end
        end
      end
    end

    assert_match(/an aria-label is required/, error.message)
  end

  def test_aria_labels_for_section_list
    nav_list = Primer::Alpha::NavigationList.new(aria: { label: "Items" })
    render_inline(nav_list) do |component|
      component.section(aria: { label: "Section" }) do |section|
        section.heading { "List" }
        component.item(selected_by_ids: :item, href: "/item") { "Item" }
      end
    end

    section_id = nav_list.sections[0].id
    assert_selector(".ActionList-sectionDivider h3[id='#{section_id}']", text: "List")
    assert_selector(".ActionList.ActionList--subGroup[aria-labelledby='#{section_id}']")
  end

  def test_subitems
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |item|
        item.subitem(selected_by_ids: :subitem, href: "/subitem") { "Subitem" }
        "Item"
      end
    end

    assert_selector(".ActionList-item.ActionList-item--hasSubItem button[aria-expanded]", text: "Item") do
      assert_selector(".ActionList-item.ActionList-item--subItem", text: "Subitem")
    end
  end

  def test_subitem_with_trailing_icon_visual
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |item|
        item.subitem(selected_by_ids: :subitem, href: "/subitem") do |subitem|
          subitem.trailing_visual_icon(icon: :"mark-github")
          "Subitem"
        end
        "Item"
      end
    end

    assert_selector("ul.ActionList") do
      assert_selector("li.ActionList-item.ActionList-item--hasSubItem") do
        assert_selector(".ActionList-item-label", text: "Item")
        assert_selector("ul.ActionList.ActionList--subGroup") do
          assert_selector("li.ActionList-item.ActionList-item--subItem") do
            assert_selector(".ActionList-item-visual.ActionList-item-visual--trailing svg.octicon-mark-github")
          end
        end
      end
    end
  end

  def test_subitem_with_trailing_label_visual
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |item|
        item.subitem(selected_by_ids: :subitem, href: "/subitem") do |subitem|
          subitem.trailing_visual_label(label: "Label") { "Label" }
          "Subitem"
        end
        "Item"
      end
    end

    assert_selector("ul.ActionList") do
      assert_selector("li.ActionList-item.ActionList-item--hasSubItem") do
        assert_selector(".ActionList-item-label", text: "Item")
        assert_selector("ul.ActionList.ActionList--subGroup") do
          assert_selector("li.ActionList-item.ActionList-item--subItem") do
            assert_selector(".ActionList-item-visual.ActionList-item-visual--trailing span.Label", text: "Label")
          end
        end
      end
    end
  end

  def test_subitem_with_trailing_counter_visual
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item, href: "/item") do |item|
        item.subitem(selected_by_ids: :subitem, href: "/subitem") do |subitem|
          subitem.trailing_visual_counter(count: 35)
          "Subitem"
        end
        "Item"
      end
    end

    assert_selector("ul.ActionList") do
      assert_selector("li.ActionList-item.ActionList-item--hasSubItem") do
        assert_selector(".ActionList-item-label", text: "Item")
        assert_selector("ul.ActionList.ActionList--subGroup") do
          assert_selector("li.ActionList-item.ActionList-item--subItem") do
            assert_selector(".ActionList-item-visual.ActionList-item-visual--trailing span.Counter", text: "35")
          end
        end
      end
    end
  end

  def test_selected_subitem
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" }, selected_item_id: :subitem4)) do |component|
      component.item(selected_by_ids: :item1, href: "/item1") do |item|
        item.subitem(selected_by_ids: :subitem1, href: "/subitem1") { "Subitem 1" }
        item.subitem(selected_by_ids: :subitem2, href: "/subitem2") { "Subitem 2" }
        "Item 1"
      end

      component.item(selected_by_ids: :item2, href: "/item2") do |item|
        item.subitem(selected_by_ids: :subitem3, href: "/subitem3") { "Subitem 3" }
        item.subitem(selected_by_ids: :subitem4, href: "/subitem4") { "Subitem 4" }
        item.subitem(selected_by_ids: :subitem5, href: "/subitem5") { "Subitem 5" }
        "Item 2"
      end
    end

    assert_selector(".ActionList-item.ActionList-item--hasSubItem button[aria-expanded='false']", text: "Item 1")

    assert_selector(".ActionList-item.ActionList-item--hasSubItem button[aria-expanded='true']", text: "Item 2") do
      assert_selector("ul.ActionList.ActionList--subGroup") do
        assert_selector("li.ActionList-item.ActionList-item--subItem") do
          assert_selector(".ActionList-content[aria-current='page']", text: "Subitem 4")
        end
      end
    end
  end

  def test_expander_arrow_when_subitems_exist
    render_inline(Primer::Alpha::NavigationList.new(aria: { label: "Items" })) do |component|
      component.item(selected_by_ids: :item1, href: "/item1") { "Item 1" }
      component.item(selected_by_ids: :item2, href: "/item2") do |item|
        item.subitem(selected_by_ids: :subitem1, href: "/subitem1") { "Subitem 1" }
        item.subitem(selected_by_ids: :subitem2, href: "/subitem2") { "Subitem 2" }
        "Item 2"
      end
    end

    # apparently refute_selector doesn't support nesting?
    refute_selector("ul.ActionList a[href='/item1'].ActionList-content .ActionList-item-action--trailing")

    assert_selector("ul.ActionList.ActionList--subGroup") do
      assert_selector("li.ActionList-item.ActionList-item--subItem") do
        assert_selector(".ActionList-item-action.ActionList-item-action--trailing .ActionList-item-collapseIcon")
      end
    end
  end
end
