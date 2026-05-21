# frozen_string_literal: true

require "system/test_case"
require "test_helpers/tree_view_helpers"

module OpenProject
  class IntegrationFilterableTreeViewTest < System::TestCase
    include Primer::TreeViewHelpers

    def test_filtering_matches_sub_trees
      visit_preview(:default)

      assert_path("Students", "Ravenclaw", "Luna Lovegood")
      assert_path("Students", "Slytherin", "Draco Malfoy")

      fill_in "Filter", with: "Raven"

      assert_path("Students", "Ravenclaw")
      assert_path_enabled("Students", "Ravenclaw")

      # non-matching parent is disabled, but visible
      refute_path_enabled("Students")

      # non-matching leaves are not visible
      refute_path("Students", "Ravenclaw", "Luna Lovegood")
      refute_path("Students", "Slytherin", "Draco Malfoy")
    end

    def test_selected_fiter_mode_shows_only_checked_nodes
      visit_preview(:default)

      # check that these are both 1) visible, and 2) unchecked
      assert_path("Students", "Gryffindor", "Harry Potter")
      assert_path("Students", "Ravenclaw", "Luna Lovegood")
      refute_path_checked("Students", "Gryffindor", "Harry Potter")
      refute_path_checked("Students", "Ravenclaw", "Luna Lovegood")

      check_at_path("Students", "Gryffindor", "Harry Potter")
      check_at_path("Students", "Ravenclaw", "Luna Lovegood")

      within("segmented-control") do
        click_on "Selected"
      end

      assert_path_checked("Students", "Gryffindor", "Harry Potter")
      assert_path_checked("Students", "Ravenclaw", "Luna Lovegood")

      # check that these are both 1) invisible, and 2) unchecked
      refute_path("Students", "Hufflepuff", "Susan Bones")
      refute_path("Albus Dumbledore")
      refute_path_checked("Students", "Hufflepuff", "Susan Bones")
      refute_path_checked("Albus Dumbledore")
    end

    def test_unchecking_node_in_selected_filter_mode_does_not_disappear_node
      visit_preview(:default)

      refute_path_checked("Students", "Gryffindor", "Harry Potter")
      check_at_path("Students", "Gryffindor", "Harry Potter")
      assert_path_checked("Students", "Gryffindor", "Harry Potter")

      within("segmented-control") do
        click_on "Selected"
      end

      assert_path_checked("Students", "Gryffindor", "Harry Potter")
      uncheck_at_path("Students", "Gryffindor", "Harry Potter")
      assert_path("Students", "Gryffindor", "Harry Potter")
      refute_path_checked("Students", "Gryffindor", "Harry Potter")
    end

    def test_checking_parent_when_sub_items_not_included_does_not_check_children
      visit_preview(:default)

      refute_checked_field "Include sub-items"

      check_at_path("Students", "Gryffindor")
      assert_path_checked("Students", "Gryffindor")

      refute_path_checked("Students", "Gryffindor", "Harry Potter")
      refute_path_checked("Students", "Gryffindor", "Ronald Weasley")
      refute_path_checked("Students", "Gryffindor", "Hermione Granger")
    end

    def test_checking_parent_when_sub_items_included_checks_children
      visit_preview(:default)

      check "Include sub-items"
      assert_checked_field "Include sub-items"

      check_at_path("Students", "Gryffindor")

      assert_path_checked("Students", "Gryffindor", "Harry Potter")
      assert_path_checked("Students", "Gryffindor", "Ronald Weasley")
      assert_path_checked("Students", "Gryffindor", "Hermione Granger")
    end

    def test_disabled_children_when_sub_items_included_checked
      visit_preview(:default)

      check_at_path("Students", "Gryffindor")

      assert_path_checked("Students", "Gryffindor")
      refute_path_checked("Students", "Gryffindor", "Harry Potter")
      refute_path_checked("Students", "Gryffindor", "Ronald Weasley")
      refute_path_checked("Students", "Gryffindor", "Hermione Granger")

      assert_path_enabled("Students", "Gryffindor", "Harry Potter")
      assert_path_enabled("Students", "Gryffindor", "Ronald Weasley")
      assert_path_enabled("Students", "Gryffindor", "Hermione Granger")

      check "Include sub-items"
      assert_checked_field "Include sub-items"

      assert_path_checked("Students", "Gryffindor")
      assert_path_checked("Students", "Gryffindor", "Harry Potter")
      assert_path_checked("Students", "Gryffindor", "Ronald Weasley")
      assert_path_checked("Students", "Gryffindor", "Hermione Granger")

      refute_path_enabled("Students", "Gryffindor", "Harry Potter")
      refute_path_enabled("Students", "Gryffindor", "Ronald Weasley")
      refute_path_enabled("Students", "Gryffindor", "Hermione Granger")
    end

    def remember_selection_state_when_toggling_sub_items_included
      visit_preview(:default)

      refute_checked_field "Include sub-items"

      check_at_path("Students", "Gryffindor", "Harry Potter")
      assert_path_checked("Students", "Gryffindor", "Harry Potter")
      refute_path_checked("Students", "Gryffindor")
      refute_path_checked("Students", "Gryffindor", "Hermione Granger")
      refute_path_checked("Students", "Gryffindor", "Ronald Weasley")

      check "Include sub-items"
      assert_checked_field "Include sub-items"

      check_at_path("Students", "Gryffindor")

      assert_path_checked("Students", "Gryffindor", "Harry Potter")
      assert_path_checked("Students", "Gryffindor", "Ronald Weasley")
      assert_path_checked("Students", "Gryffindor", "Hermione Granger")

      check "Include sub-items"
      assert_unchecked_field "Include sub-items"

      # Remember what was selected before
      assert_path_checked("Students", "Gryffindor", "Harry Potter")
      refute_path_checked("Students", "Gryffindor")
      refute_path_checked("Students", "Gryffindor", "Hermione Granger")
      refute_path_checked("Students", "Gryffindor", "Ronald Weasley")
    end

    def test_checking_parent_with_sub_items_included_when_children_filtered_out
      visit_preview(:default)

      check "Include sub-items"
      assert_checked_field "Include sub-items"

      fill_in "Filter", with: "Ravenclaw"

      check_at_path("Students", "Ravenclaw")
      assert_path_checked("Students", "Ravenclaw")

      find(".FormControl button[aria-label='Clear']").click

      assert_path_checked("Students", "Ravenclaw")
      assert_path_checked("Students", "Ravenclaw", "Luna Lovegood")
    end

    def test_hides_nodes_that_do_not_match_filter_text
      visit_preview(:default)

      fill_in "Filter", with: "Luna"

      assert_path("Students", "Ravenclaw", "Luna Lovegood")

      # these should all be invisible
      refute_path("Students", "Gryffindor", "Harry Potter")
      refute_path("Students", "Hufflepuff", "Susan Bones")
      refute_path("Albus Dumbledore")
    end

    def test_enables_parent_nodes_that_match_filter_text
      visit_preview(:default)

      fill_in "Filter", with: "l"

      refute_path_enabled("Students")
      assert_path_enabled("Students", "Ravenclaw")
      assert_path_enabled("Students", "Ravenclaw", "Luna Lovegood")
      assert_path_enabled("Students", "Slytherin")
      assert_path_enabled("Students", "Slytherin", "Draco Malfoy")
      refute_path_enabled("Students", "Gryffindor")
      assert_path_enabled("Students", "Gryffindor", "Ronald Weasley")
    end

    def test_disables_parent_nodes_that_do_not_match_filter_text
      visit_preview(:default)

      fill_in "Filter", with: "Luna"

      assert_path_enabled("Students", "Ravenclaw", "Luna Lovegood")

      refute_path_enabled("Students")
      refute_path_enabled("Students", "Ravenclaw")
    end

    def test_automatically_expands_sub_trees_to_show_matching_items
      visit_preview(:default, expanded: false)

      refute_path("Students", "Gryffindor", "Ronald Weasley")

      fill_in "Filter", with: "Ron"

      assert_path("Students", "Gryffindor", "Ronald Weasley")
    end

    def test_form_submits_checked_nodes_for_single_select_variant
      visit_preview(:form_input, select_variant: :single)

      assert_path_checked("Students", "Slytherin", "Draco Malfoy")
      activate_at_path("Students", "Gryffindor", "Harry Potter")
      activate_at_path("Students", "Ravenclaw", "Luna Lovegood")
      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")

      # Since we are in single select mode, only the last checked element is selected and send
      assert_equal 1, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Ravenclaw", "Luna Lovegood"]
    end

    def test_initial_form_state_for_single_select
      visit_preview(:form_input, select_variant: :single)

      assert_path_checked("Students", "Slytherin", "Draco Malfoy")

      find("button[type=submit]").click

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 1, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Slytherin", "Draco Malfoy"]
    end

    def test_form_submits_checked_nodes
      visit_preview(:form_input)

      assert_path_checked("Students", "Slytherin", "Draco Malfoy")
      check_at_path("Students", "Gryffindor", "Harry Potter")
      check_at_path("Students", "Ravenclaw", "Luna Lovegood")
      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 3, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Ravenclaw", "Luna Lovegood"]

      character = JSON.parse(character_list[1])
      assert_equal character["path"], ["Students", "Slytherin", "Draco Malfoy"]

      character = JSON.parse(character_list[2])
      assert_equal character["path"], ["Students", "Gryffindor", "Harry Potter"]
    end

    def test_initial_form_state_for_multi_select
      visit_preview(:form_input)

      assert_path_checked("Students", "Slytherin", "Draco Malfoy")

      find("button[type=submit]").click

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 1, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Slytherin", "Draco Malfoy"]
    end

    def test_form_submits_checked_nodes_when_sub_items_included_checked
      visit_preview(:form_input)

      assert_path_checked("Students", "Slytherin", "Draco Malfoy")

      check "Include sub-items"
      assert_checked_field "Include sub-items"

      check_at_path("Students", "Ravenclaw")

      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 3, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Ravenclaw"]

      character = JSON.parse(character_list[1])
      assert_equal character["path"], ["Students", "Ravenclaw", "Luna Lovegood"]

      character = JSON.parse(character_list[2])
      assert_equal character["path"], ["Students", "Slytherin", "Draco Malfoy"]
    end

    def test_form_submits_checked_nodes_when_items_filtered_out
      visit_preview(:form_input)

      assert_path_checked("Students", "Slytherin", "Draco Malfoy")

      check_at_path("Students", "Ravenclaw")

      fill_in "Filter", with: "Harry"

      check_at_path("Students", "Gryffindor", "Harry Potter")

      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 3, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Ravenclaw"]

      character = JSON.parse(character_list[1])
      assert_equal character["path"], ["Students", "Slytherin", "Draco Malfoy"]

      character = JSON.parse(character_list[2])
      assert_equal character["path"], ["Students", "Gryffindor", "Harry Potter"]
    end

    def test_form_submits_checked_nodes_when_filtering_for_selected_only
      visit_preview(:form_input)

      assert_path_checked("Students", "Slytherin", "Draco Malfoy")
      check_at_path("Students", "Ravenclaw")
      check_at_path("Students", "Ravenclaw", "Luna Lovegood")

      within("segmented-control") do
        click_on "Selected"
      end

      uncheck_at_path("Students", "Ravenclaw", "Luna Lovegood")

      assert_path_checked("Students", "Slytherin", "Draco Malfoy")
      assert_path_checked("Students", "Ravenclaw")
      refute_path_checked("Students", "Ravenclaw", "Luna Lovegood")

      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 2, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Ravenclaw"]

      character = JSON.parse(character_list[1])
      assert_equal character["path"], ["Students", "Slytherin", "Draco Malfoy"]
    end

    # ─── Async: initial load ─────────────────────────────────────────────────

    HOGWARTS    = "Hogwarts School of Witchcraft and Wizardry"
    BEAUXBATONS = "Beauxbatons Academy of Magic"
    DURMSTRANG  = "Durmstrang Institute"

    def test_loads_tree_on_initial_render
      visit_preview(:async, select_variant: :multiple)

      assert_path(HOGWARTS)
      assert_path(BEAUXBATONS)
      assert_path(DURMSTRANG)
      assert_no_selector "filterable-tree-view[data-loading]"
    end

    # ─── Query filtering ─────────────────────────────────────────────────────

    def test_filters_tree_by_query
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)

      fill_in "Filter", with: "Viktor"

      assert_path(DURMSTRANG, "Students", "Viktor Krum")
      refute_path(HOGWARTS)
      refute_path(BEAUXBATONS)
    end

    def test_shows_no_results_message_when_query_has_no_match
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)

      fill_in "Filter", with: "zzz_no_match"

      assert_selector "[data-target='filterable-tree-view.noResultsMessage']", visible: true
    end

    def test_clears_no_results_message_when_filter_is_removed
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)

      fill_in "Filter", with: "zzz_no_match"
      assert_selector "[data-target='filterable-tree-view.noResultsMessage']", visible: true

      find(".FormControl button[aria-label='Clear']").click

      assert_path(HOGWARTS)
      assert_no_selector "[data-target='filterable-tree-view.noResultsMessage']", visible: true
    end

    def test_expands_all_results_when_filtering
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)
      # Children not visible yet (tree starts collapsed)
      refute_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")

      fill_in "Filter", with: "Harry"

      assert_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
    end

    # ─── Expansion state persistence ─────────────────────────────────────────

    def test_restores_expansion_state_when_filter_is_cleared
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)

      # Expand Hogwarts → Students → Gryffindor; leave Durmstrang collapsed
      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")
      expand_at_path(HOGWARTS, "Students", "Gryffindor")
      assert_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      refute_path(DURMSTRANG, "Students")

      fill_in "Filter", with: "Harry"
      assert_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")

      find(".FormControl button[aria-label='Clear']").click

      # Pre-filter expansion is restored
      assert_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      # Durmstrang was never expanded, stays collapsed
      refute_path(DURMSTRANG, "Students")
    end

    # ─── Selection state persistence ─────────────────────────────────────────

    def test_preserves_checked_nodes_across_tree_replacement
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)

      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")
      expand_at_path(HOGWARTS, "Students", "Gryffindor")

      check_at_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      assert_path_checked(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      check_at_path(HOGWARTS, "Students", "Gryffindor", "Ron Weasley")
      assert_path_checked(HOGWARTS, "Students", "Gryffindor", "Ron Weasley")

      fill_in "Filter", with: "Harry"

      # Node is still checked after the tree has been replaced
      assert_path_checked(HOGWARTS, "Students", "Gryffindor", "Harry Potter")

      find(".FormControl button[aria-label='Clear']").click

      # Both, Harry and Ron are still checked after the tree has been replaced
      assert_path_checked(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      assert_path_checked(HOGWARTS, "Students", "Gryffindor", "Ron Weasley")
    end

    # ─── "Selected" filter mode ───────────────────────────────────────────────

    def test_selected_mode_shows_only_checked_nodes
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)

      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")
      expand_at_path(HOGWARTS, "Students", "Gryffindor")
      check_at_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")

      within("segmented-control") { click_on "Selected" }

      assert_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      refute_path(DURMSTRANG)
      refute_path(BEAUXBATONS)
    end

    def test_selected_mode_also_applies_query_filter
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)

      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")
      expand_at_path(HOGWARTS, "Students", "Gryffindor")
      check_at_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      check_at_path(HOGWARTS, "Students", "Gryffindor", "Ron Weasley")

      within("segmented-control") { click_on "Selected" }

      assert_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      assert_path(HOGWARTS, "Students", "Gryffindor", "Ron Weasley")

      fill_in "Filter", with: "Harry"

      assert_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      refute_path(HOGWARTS, "Students", "Gryffindor", "Ron Weasley")
    end

    def test_returning_to_all_mode_restores_expansion_state
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)

      # Expand Hogwarts → Students; leave Durmstrang collapsed
      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")
      assert_path(HOGWARTS, "Students")
      refute_path(DURMSTRANG, "Students")

      within("segmented-control") { click_on "Selected" }
      within("segmented-control") { click_on "All" }

      # Expansion state from before "Selected" mode must be preserved (no server round-trip)
      assert_path(HOGWARTS, "Students")
      refute_path(DURMSTRANG, "Students")
    end

    # ─── Include sub-items ────────────────────────────────────────────────────

    def test_include_sub_items_checks_and_disables_visible_children
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)

      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")

      check "Include sub-items"
      check_at_path(HOGWARTS, "Students")

      assert_path_checked(HOGWARTS, "Students")
      assert_path_checked(HOGWARTS, "Students", "Gryffindor")
      refute_path_enabled(HOGWARTS, "Students", "Gryffindor")
    end

    def test_include_sub_items_toggle_does_not_replace_tree
      visit_preview(:async, select_variant: :multiple)
      assert_path(HOGWARTS)

      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")

      # Remember the tree-view element reference to detect replacement
      tree_id = page.evaluate_script("document.querySelector('tree-view').dataset.testId ||= crypto.randomUUID()")

      check "Include sub-items"

      # The same tree-view element must still be in the DOM (no replacement)
      assert page.evaluate_script("document.querySelector(`tree-view[data-test-id='#{tree_id}']`) !== null")
    end

    # ─── Single select variant ────────────────────────────────────────────────

    def test_async_single_select_replaces_previous_selection
      visit_preview(:async, select_variant: :single)
      assert_path(HOGWARTS)

      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")
      expand_at_path(HOGWARTS, "Students", "Gryffindor")
      activate_at_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      assert_path_checked(HOGWARTS, "Students", "Gryffindor", "Harry Potter")

      expand_at_path(DURMSTRANG)
      expand_at_path(DURMSTRANG, "Students")
      activate_at_path(DURMSTRANG, "Students", "Viktor Krum")

      assert_path_checked(DURMSTRANG, "Students", "Viktor Krum")
      refute_path_checked(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
    end

    def test_async_single_select_does_not_restore_previous_selection_after_tree_replacement
      # Regression: #checkedNodeIds accumulated stale entries across replacements.
      # Selecting A, then filtering (replacement), then selecting B caused both A
      # and B to be re-checked when the tree was next replaced.
      visit_preview(:async, select_variant: :single)
      assert_path(HOGWARTS)

      # Select Harry Potter (node A)
      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")
      expand_at_path(HOGWARTS, "Students", "Gryffindor")
      activate_at_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      assert_path_checked(HOGWARTS, "Students", "Gryffindor", "Harry Potter")

      # Filter — this triggers a tree replacement; Harry Potter is no longer in the DOM
      fill_in "Filter", with: "Viktor"
      assert_path(DURMSTRANG, "Students", "Viktor Krum")
      refute_path(HOGWARTS)

      # Select Viktor Krum (node B)
      activate_at_path(DURMSTRANG, "Students", "Viktor Krum")
      assert_path_checked(DURMSTRANG, "Students", "Viktor Krum")

      # Clear filter — full tree is restored via another replacement
      find(".FormControl button[aria-label='Clear']").click
      assert_path(HOGWARTS)

      # Only Viktor Krum must be checked; Harry Potter must NOT be checked
      expand_at_path(DURMSTRANG)
      expand_at_path(DURMSTRANG, "Students")
      assert_path_checked(DURMSTRANG, "Students", "Viktor Krum")
      refute_path_checked(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
    end

    # ─── Async form: include_sub_items flag ───────────────────────────────────

    def test_async_form_includes_include_sub_items_in_submission_when_checked
      visit_preview(:async_form_input)
      assert_path(HOGWARTS)

      check "Include sub-items"
      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")
      check_at_path(HOGWARTS, "Students")
      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert_equal "1", response.dig("form_params", "include_sub_items")
    end

    def test_async_form_does_not_include_include_sub_items_when_unchecked
      visit_preview(:async_form_input)
      assert_path(HOGWARTS)

      refute_checked_field "Include sub-items"
      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")
      expand_at_path(HOGWARTS, "Students", "Gryffindor")
      check_at_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")
      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert_equal "0", response.dig("form_params", "include_sub_items")
    end

    # ─── Async form: retained selections ─────────────────────────────────────

    def test_async_form_submits_nodes_filtered_out_of_dom
      visit_preview(:async_form_input)
      assert_path(HOGWARTS)

      # Select Viktor Krum from Durmstrang
      expand_at_path(DURMSTRANG)
      expand_at_path(DURMSTRANG, "Students")
      check_at_path(DURMSTRANG, "Students", "Viktor Krum")

      # Filter for "gry" – Durmstrang is no longer in the DOM
      fill_in "Filter", with: "gry"
      refute_path(DURMSTRANG)
      assert_path(HOGWARTS, "Students", "Gryffindor")

      # Select Gryffindor from the filtered results
      check_at_path(HOGWARTS, "Students", "Gryffindor")

      click_on "Submit"

      response = JSON.parse(find("pre").text)
      character_list = response.dig("form_params", "characters")
      paths = character_list.map { |c| JSON.parse(c)["path"] }

      assert_includes paths, [DURMSTRANG, "Students", "Viktor Krum"],
                      "Expected retained selection (Viktor Krum) to be in form params"
      assert_includes paths, [HOGWARTS, "Students", "Gryffindor"],
                      "Expected visible selection (Gryffindor) to be in form params"
    end

    def test_async_form_does_not_duplicate_nodes_in_dom
      visit_preview(:async_form_input)
      assert_path(HOGWARTS)

      expand_at_path(HOGWARTS)
      expand_at_path(HOGWARTS, "Students")
      expand_at_path(HOGWARTS, "Students", "Gryffindor")
      check_at_path(HOGWARTS, "Students", "Gryffindor", "Harry Potter")

      click_on "Submit"

      response = JSON.parse(find("pre").text)
      character_list = response.dig("form_params", "characters")
      paths = character_list.map { |c| JSON.parse(c)["path"] }
      harry_entries = paths.count { |p| p == [HOGWARTS, "Students", "Gryffindor", "Harry Potter"] }

      assert_equal 1, harry_entries, "Harry Potter should appear exactly once in form params"
    end

    def test_async_form_clears_retained_selection_when_filter_is_removed
      visit_preview(:async_form_input)
      assert_path(HOGWARTS)

      # Select Viktor Krum, filter away, then clear filter
      expand_at_path(DURMSTRANG)
      expand_at_path(DURMSTRANG, "Students")
      check_at_path(DURMSTRANG, "Students", "Viktor Krum")

      fill_in "Filter", with: "gry"
      refute_path(DURMSTRANG)

      find(".FormControl button[aria-label='Clear']").click

      # Expansion state is restored – Durmstrang and Students are already open
      uncheck_at_path(DURMSTRANG, "Students", "Viktor Krum")

      click_on "Submit"

      response = JSON.parse(find("pre").text)
      character_list = response.dig("form_params", "characters") || []
      paths = character_list.map { |c| JSON.parse(c)["path"] }

      refute_includes paths, [DURMSTRANG, "Students", "Viktor Krum"],
                      "Viktor Krum should not appear after being unchecked"
    end
  end
end
