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

    def test_form_submits_checked_nodes
      visit_preview(:form_input)

      check_at_path("Students", "Gryffindor", "Harry Potter")
      check_at_path("Students", "Ravenclaw", "Luna Lovegood")
      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 2, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Ravenclaw", "Luna Lovegood"]


      character = JSON.parse(character_list[1])
      assert_equal character["path"], ["Students", "Gryffindor", "Harry Potter"]
    end

    def test_form_submits_checked_nodes_when_sub_items_included_checked
      visit_preview(:form_input)

      check "Include sub-items"
      assert_checked_field "Include sub-items"

      check_at_path("Students", "Ravenclaw")

      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 2, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Ravenclaw"]

      character = JSON.parse(character_list[1])
      assert_equal character["path"], ["Students", "Ravenclaw", "Luna Lovegood"]
    end

    def test_form_submits_checked_nodes_when_items_filtered_out
      visit_preview(:form_input)

      check_at_path("Students", "Ravenclaw")

      fill_in "Filter", with: "Harry"

      check_at_path("Students", "Gryffindor", "Harry Potter")

      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 2, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Ravenclaw"]

      character = JSON.parse(character_list[1])
      assert_equal character["path"], ["Students", "Gryffindor", "Harry Potter"]
    end

    def test_form_submits_checked_nodes_when_filtering_for_selected_only
      visit_preview(:form_input)

      check_at_path("Students", "Ravenclaw")
      check_at_path("Students", "Ravenclaw", "Luna Lovegood")

      within("segmented-control") do
        click_on "Selected"
      end

      uncheck_at_path("Students", "Ravenclaw", "Luna Lovegood")

      assert_path_checked("Students", "Ravenclaw")
      refute_path_checked("Students", "Ravenclaw", "Luna Lovegood")

      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 1, character_list.size

      character = JSON.parse(character_list[0])
      assert_equal character["path"], ["Students", "Ravenclaw"]
    end
  end
end
