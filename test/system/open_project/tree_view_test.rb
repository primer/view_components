# frozen_string_literal: true

require "system/test_case"

module OpenProject
  class IntegrationTreeViewTest < System::TestCase
    include Primer::KeyboardTestHelpers
    include Primer::JsTestHelpers

    ##### TEST HELPERS #####

    def selector_for(*path)
      "[role=treeitem][data-path='#{path.to_json}']"
    end

    def activate_at_path(*path)
      find("#{selector_for(*path)} .TreeViewItemContainer", match: :first).click
    end

    def check_at_path(*path)
      find("#{selector_for(*path)} .TreeViewItemCheckbox", match: :first).click
    end

    def label_at_path(*path)
      label_of(node_at_path(*path))
    end

    def label_of(node)
      return unless node
      return unless node.tag_name == "li"
      return unless node["role"] == "treeitem"

      node.find_css(".TreeViewItemContentText").first.all_text
    end

    def node_at_path(*path)
      find(selector_for(*path), match: :first)
    end

    def current_node
      find_all("[role=treeitem][aria-current]").first
    end

    def active_element
      page.evaluate_script("document.activeElement")
    end

    def assert_path(*path)
      assert_selector selector_for(*path)
    end

    def refute_path(*path)
      refute_selector selector_for(*path)
    end

    def assert_path_tabbable(*path)
      assert_selector "#{selector_for(*path)}[tabindex='0']"
    end

    def assert_path_selected(*path)
      assert_selector "#{selector_for(*path)}[aria-selected=true]"
    end

    def assert_path_checked(*path, value: :true)
      assert_selector "#{selector_for(*path)}[aria-checked='#{value}']"
    end

    def refute_path_checked(*path, value: :true)
      if value == :true_or_mixed
        refute_path_checked(*path, "true")
        refute_path_checked(*path, "mixed")
      else
        refute_selector "#{selector_for(*path)}[aria-checked='#{value}']"
      end
    end

    def remove_fail_param_from_fragment_src_for(*path)
      evaluate_multiline_script(<<~JS)
        const selector = CSS.escape(JSON.stringify(#{path.inspect}))
        const includeFragment = document.querySelector(`[data-path="${selector}"] tree-view-include-fragment`)
        const relativeUrl = includeFragment.getAttribute('src')
        const url = new URL(relativeUrl, 'http://dummy')
        url.searchParams.delete('fail')
        const newUrl = `${url.pathname}?${url.searchParams.toString()}`
        includeFragment.setAttribute('src', newUrl)
      JS
    end

    ##### TESTS #####

    def test_expands
      visit_preview(:default)
      activate_at_path("src")

      assert_path "src", "button.rb"
      assert_path "src", "icon_button.rb"

      node_at_path("src").tap do |node|
        assert_equal "true", node["aria-expanded"]
      end
    end

    def test_collapses
      visit_preview(:default)
      activate_at_path("src")

      node_at_path("src").tap do |node|
        assert_equal "true", node["aria-expanded"]
      end

      # should collapse
      activate_at_path("src")

      refute_path "src", "button.rb"
      refute_path "src", "icon_button.rb"

      node_at_path("src").tap do |node|
        assert_equal "false", node["aria-expanded"]
      end
    end

    def test_expanded_and_collapsed_icons
      visit_preview(:default)

      assert_selector "#{selector_for("src")} .TreeViewItemVisual svg.octicon-file-directory-fill"
      activate_at_path("src")
      assert_selector "#{selector_for("src")} .TreeViewItemVisual svg.octicon-file-directory-open-fill"
    end

    def test_current
      visit_preview(:default)

      refute current_node
      activate_at_path("src")

      assert current_node
      assert_equal label_of(current_node), "icon_button.rb"
    end

    def test_first_item_tabbable_when_no_current
      visit_preview(:default)

      assert_path_tabbable("src")
    end

    def test_current_item_tabbable
      visit_preview(:default, expanded: true)

      assert_path_tabbable("src", "icon_button.rb")
    end

    def test_tab_selects_current_item
      visit_preview(:default, expanded: true)

      refute label_of(active_element)

      keyboard.type(:tab)

      assert_equal label_of(active_element), "icon_button.rb"
      assert_path_selected("src", "icon_button.rb")
    end

    def test_tree_tabbable_after_parent_of_focused_item_is_collapsed
      visit_preview(:default, expanded: true)

      keyboard.type(:tab)
      assert_path_selected("src", "icon_button.rb")

      activate_at_path("src")

      # collapsed node now tabbable
      assert_path_tabbable("src")
    end

    ##### KEYBOARD NAVIGATION #####

    def test_expands_on_enter
      visit_preview(:default)

      keyboard.type(:tab, :enter)
      assert_path("src", "button.rb")
    end

    def test_collapses_on_enter
      visit_preview(:default)

      keyboard.type(:tab, :enter)
      assert_path("src", "button.rb")

      keyboard.type(:enter)
      refute_path("src", "button.rb")
    end

    def test_expands_on_right_arrow
      visit_preview(:default)

      keyboard.type(:tab, :right)
      assert_path("src", "button.rb")
    end

    def test_collapses_on_left_arrow
      visit_preview(:default)

      keyboard.type(:tab, :right)
      assert_path("src", "button.rb")

      keyboard.type(:left)
      refute_path("src", "button.rb")
    end

    def test_arrow_down_selects_next_visible_node
      visit_preview(:default)

      keyboard.type(:tab, :down)

      assert_equal label_of(active_element), "action_menu.rb"
      assert_path_selected("action_menu.rb")
    end

    def test_arrow_up_selects_previous_visible_node
      visit_preview(:default)

      keyboard.type(:tab, :down)

      assert_equal label_of(active_element), "action_menu.rb"
      assert_path_selected("action_menu.rb")

      keyboard.type(:up)

      assert_equal label_of(active_element), "src"
      assert_path_selected("src")
    end

    def test_arrow_down_selects_expanded_item
      visit_preview(:default)

      keyboard.type(:tab, :enter, :down)

      assert_equal label_of(active_element), "button.rb"
      assert_path_selected("src", "button.rb")
    end

    ##### LOADERS #####

    def test_loading_spinner
      visit_preview(:loading_spinner)

      activate_at_path("primer")

      # assert loader appears and is subsequently replaced
      assert_selector "#{selector_for("primer", "loader")} svg"
      assert_selector "#{selector_for("primer", "alpha")}"

      # assert loader is gone
      refute_selector "#{selector_for("primer", "loader")}"
    end

    def test_selecting_spinner_causes_selection_to_move_to_first_loaded_node
      visit_preview(:loading_spinner)

      keyboard.type(:tab, :enter)
      assert_path("primer", "loader")
      keyboard.type(:down)

      assert_path_selected("primer", "alpha")
    end

    def test_loading_spinner_failure
      visit_preview(:loading_spinner, simulate_failure: true)

      activate_at_path("primer")

      assert_selector "#{selector_for("primer")} .TreeViewFailureMessage", text: "Something went wrong"
    end

    def test_loading_spinner_retry_after_failure
      visit_preview(:loading_spinner, simulate_failure: true)

      activate_at_path("primer")
      assert_selector "#{selector_for("primer")} .TreeViewFailureMessage"

      remove_fail_param_from_fragment_src_for("primer")
      click_on("Retry")

      assert_path("primer", "alpha")
      refute_selector "#{selector_for("primer")} .TreeViewFailureMessage"
    end

    def test_empty_after_loading_spinner
      visit_preview(:loading_spinner, simulate_empty: true)

      activate_at_path("primer")
      refute_selector("tree-view-include-fragment") # wait for fragment to load

      assert_selector "#{selector_for("primer")} .TreeViewItemContentText", text: "No items"
    end

    def test_loading_skeleton
      visit_preview(:loading_skeleton)

      activate_at_path("primer")

      # assert loader appears and is subsequently replaced
      assert_selector "#{selector_for("primer", "loader")} .SkeletonBox"
      assert_selector "#{selector_for("primer", "alpha")}"

      # assert loader is gone
      refute_selector "#{selector_for("primer", "loader")}"
    end

    def test_selecting_skeleton_causes_selection_to_move_to_first_loaded_node
      visit_preview(:loading_skeleton)

      keyboard.type(:tab, :enter)
      assert_path("primer", "loader")
      keyboard.type(:down)

      assert_path_selected("primer", "alpha")
    end

    def test_loading_skeleton_failure
      visit_preview(:loading_skeleton, simulate_failure: true)

      activate_at_path("primer")

      assert_selector "#{selector_for("primer")} .TreeViewFailureMessage", text: "Something went wrong"
    end

    def test_loading_skeleton_retry_after_failure
      visit_preview(:loading_skeleton, simulate_failure: true)

      activate_at_path("primer")
      assert_selector "#{selector_for("primer")} .TreeViewFailureMessage"

      remove_fail_param_from_fragment_src_for("primer")
      click_on("Retry")

      assert_path("primer", "alpha")
      refute_selector "#{selector_for("primer")} .TreeViewFailureMessage"
    end

    def test_empty_after_loading_skeleton
      visit_preview(:loading_skeleton, simulate_empty: true)

      activate_at_path("primer")

      assert_selector "#{selector_for("primer")} .TreeViewItemContentText", text: "No items"
    end

    def test_empty
      visit_preview(:empty)

      activate_at_path("src")

      assert_selector "#{selector_for("src")} .TreeViewItemContentText", text: "No items"
    end

    def capture_event(event_name, cancel: false)
      evaluate_multiline_script(<<~JS)
        window.treeViewEventDetails = null
        const treeViewShouldCancelEvent = #{cancel}

        document.querySelector('tree-view').addEventListener('#{event_name}', (event) => {
          window.treeViewEventDetails = event.detail

          if (treeViewShouldCancelEvent) {
            event.preventDefault()
          }
        })
      JS

      yield

      return page.evaluate_script("window.treeViewEventDetails")
    end

    ##### JAVASCRIPT EVENTS #####

    def test_fires_event_before_activation
      visit_preview(:default)

      details = capture_event("treeViewBeforeNodeActivated") do
        activate_at_path("src")
      end

      assert details["node"]
      assert_equal details["type"], "sub-tree"
      assert_equal details["path"], ["src"]
      assert_equal details["checkedValue"], "false"
      assert_equal details["previousCheckedValue"], "false"
    end

    def test_canceling_activation_event_prevents_expansion
      visit_preview(:default)

      refute_path "src", "button.rb"

      capture_event("treeViewBeforeNodeActivated", cancel: true) do
        activate_at_path("src")
      end

      # src should still be collapsed
      refute_path "src", "button.rb"
    end

    def test_fires_activation_event
      visit_preview(:default)

      details = capture_event("treeViewNodeActivated") do
        activate_at_path("src")
      end

      assert details["node"]
      assert_equal details["type"], "sub-tree"
      assert_equal details["path"], ["src"]
      assert_equal details["checkedValue"], "false"
      assert_equal details["previousCheckedValue"], "false"
    end

    def test_fires_event_before_checking
      visit_preview(:default, select_variant: :multiple)

      details = capture_event("treeViewBeforeNodeChecked") do
        check_at_path("src")
      end

      assert_equal details.size, 3

      assert details[0]["node"]
      assert_equal details[0]["type"], "sub-tree"
      assert_equal details[0]["path"], ["src"]
      assert_equal details[0]["checkedValue"], "true"
      assert_equal details[0]["previousCheckedValue"], "false"
    end

    def test_canceling_check_event_prevents_checking
      visit_preview(:default, select_variant: :multiple)

      refute_path_checked "src"

      capture_event("treeViewBeforeNodeChecked", cancel: true) do
        check_at_path("src")
      end

      # src should still not be checked
      refute_path_checked "src"
    end

    def test_fires_check_event
      visit_preview(:default, select_variant: :multiple)

      details = capture_event("treeViewNodeChecked") do
        check_at_path("src")
      end

      assert_equal details.size, 3

      assert details[0]["node"]
      assert_equal details[0]["type"], "sub-tree"
      assert_equal details[0]["path"], ["src"]
      assert_equal details[0]["checkedValue"], "true"
      assert_equal details[0]["previousCheckedValue"], "false"
    end

    ##### CHECKBOX BEHAVIOR #####

    def test_space_checks_leaf_node
      visit_preview(:playground, select_variant: :multiple)

      activate_at_path("primer")
      activate_at_path("primer", "alpha")
      refute_path_checked "primer", "alpha", "action_bar.pcss"

      keyboard.type(:tab, :down, :down, :down, :space)
      assert_path_checked "primer", "alpha", "action_bar.pcss"
    end

    def test_space_checks_sub_tree_node
      visit_preview(:playground, select_variant: :multiple)

      refute_path_checked "primer"

      keyboard.type(:tab, :space)
      assert_path_checked "primer"
    end

    def test_checking_sub_tree_node_checks_all_children
      visit_preview(:default, expanded: true, select_variant: :multiple)

      assert_path "src", "button.rb"
      refute_path_checked "src", "button.rb"

      assert_path "src", "button.rb"
      refute_path_checked "src", "icon_button.rb"

      check_at_path("src")

      assert_path_checked "src"
      assert_path_checked "src", "button.rb"
      assert_path_checked "src", "icon_button.rb"
    end

    def test_unchecking_sub_tree_child_results_in_mixed_parent
      visit_preview(:default, expanded: true, select_variant: :multiple)

      check_at_path("src")
      assert_path_checked "src"

      check_at_path("src", "button.rb")  # uncheck
      assert_path_checked "src", value: :mixed
      refute_path_checked "src", "button.rb"
      assert_path_checked "src", "icon_button.rb"
    end

    def test_checking_deeply_nested_child_results_in_all_mixed_ancestors
      visit_preview(:playground, expanded: true, select_variant: :multiple)

      check_at_path("primer", "alpha", "action_bar", "item.rb")

      assert_path_checked "primer", value: :mixed
      assert_path_checked "primer", "alpha", value: :mixed
      assert_path_checked "primer", "alpha", "action_bar", value: :mixed
      assert_path_checked "primer", "alpha", "action_bar", "item.rb"
    end

    def test_self_select_strategy_does_not_check_parent
      visit_preview(:playground, expanded: true, select_variant: :multiple, select_strategy: :self)

      check_at_path("primer", "alpha", "action_bar", "item.rb")

      refute_path_checked "primer", value: :true_or_mixed
      refute_path_checked "primer", "alpha", value: :true_or_mixed
      refute_path_checked "primer", "alpha", "action_bar", value: :true_or_mixed

      assert_path_checked "primer", "alpha", "action_bar", "item.rb"
    end

    def test_self_select_strategy_checking_sub_tree_does_not_check_children
      visit_preview(:playground, expanded: true, select_variant: :multiple, select_strategy: :self)

      check_at_path("primer", "alpha", "action_bar")

      refute_path_checked "primer", "alpha", "action_bar", "divider.rb", value: :true_or_mixed
      refute_path_checked "primer", "alpha", "action_bar", "item.rb", value: :true_or_mixed

      assert_path_checked "primer", "alpha", "action_bar"
    end
  end
end
