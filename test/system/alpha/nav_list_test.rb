# frozen_string_literal: true

require "system/test_case"

module Alpha
  class NavListTest < System::TestCase
    def test_collapses_group
      visit_preview(:default)

      assert_selector("[aria-expanded='true']")
      click_button("Moderation options")
      assert_selector("[aria-expanded='false']")
    end

    def test_shows_more_items
      visit_preview(:show_more_item)

      assert_selector "li.ActionListItem", count: 2
      assert_selector "li", text: "Popplers"
      assert_selector "li", text: "Slurm"

      # use #find here to wait for the button to become enabled
      find("button", text: "Show more foods").click

      assert_selector "li.ActionListItem", count: 4
      assert_selector "li", text: "Popplers"
      assert_selector "li", text: "Slurm"
      assert_selector "li", text: "Bachelor Chow"
      assert_selector "li", text: "LöBrau"
    end

    def test_js_api_allows_selecting_item_by_id
      visit_preview(:default)

      select_item_by_id(:collaborators)
      assert_item_id_selected(:collaborators)
    end

    def test_selecting_id_collapses_section
      visit_preview(:default)

      select_item_by_id(:collaborators)
      assert_selector "button[aria-expanded=false]", text: "Moderation"
    end

    def test_js_api_allows_selecting_item_by_href
      visit_preview(:default)

      select_item_by_href("/collaborators")
      assert_item_href_selected("/collaborators")
    end

    def test_selecting_href_collapses_section
      visit_preview(:default)

      select_item_by_href("/collaborators")
      assert_selector "button[aria-expanded=false]", text: "Moderation"
    end

    def test_js_api_allows_selecting_item_by_current_location
      visit_preview(:default)

      # set the URL without reloading the page
      page.evaluate_script(<<~JS)
        (() => {
          window.history.pushState({}, "", "http://localhost/collaborators")
        })();
      JS

      select_item_by_current_location
      assert_item_href_selected("/collaborators")
      assert_selector "button[aria-expanded=false]", text: "Moderation"
    end

    private

    def select_item_by_id(id)
      select_item_by(id: id)
    end

    def select_item_by_href(href)
      select_item_by(href: href)
    end

    def select_item_by_current_location
      page.evaluate_script(<<~JS)
        (() => {
          const navLists = document.querySelectorAll('nav-list');

          // Unfortunately the NavList component emits multiple <nav-list> elements,
          // so we have to loop over all of them. This will be addressed in the very
          // near future.
          for (const navList of navLists) {
            if (navList.selectItemByCurrentLocation()) {
              return;
            }
          }
        })();
      JS
    end

    def select_item_by(id: nil, href: nil)
      func = id ? "selectItemById" : "selectItemByHref"
      param = id || href

      page.evaluate_script(<<~JS)
        (() => {
          const navLists = document.querySelectorAll('nav-list');

          // Unfortunately the NavList component emits multiple <nav-list> elements,
          // so we have to loop over all of them. This will be addressed in the very
          // near future.
          for (const navList of navLists) {
            if (navList.#{func}('#{param}')) {
              return;
            }
          }
        })();
      JS
    end

    def assert_item_id_selected(item_id)
      assert_selector("li[data-item-id='#{item_id}'].ActionListItem--navActive [aria-current=true]")
    end

    def assert_item_href_selected(item_href)
      assert_selector("li.ActionListItem--navActive a[href='#{item_href}'][aria-current=true]")
    end
  end
end
