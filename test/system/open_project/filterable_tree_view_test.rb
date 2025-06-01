# frozen_string_literal: true

require "system/test_case"
require "test_helpers/tree_view_helpers"

module OpenProject
  class IntegrationFilterableTreeViewTest < System::TestCase
    include Primer::TreeViewHelpers

    def test_form_submits_checked_nodes
      visit_preview(:form_input)

      check_at_path("Hogwarts", "Gryffindor", "Harry Potter")
      check_at_path("Hogwarts", "Ravenclaw", "Luna Lovegood")
      click_on "Submit"

      response = JSON.parse(find("pre").text)
      assert character_list = response.dig("form_params", "characters")
      assert_equal 2, character_list.size

      character = JSON.parse(character_list[0])
      assert character["path"], ["Hogwarts", "Gryffindor", "Harry Potter"]

      character = JSON.parse(character_list[1])
      assert character["path"], ["Hogwarts", "Hufflepuff", "Luna Lovegood"]
    end
  end
end
