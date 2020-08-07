# frozen_string_literal: true

require "test_helper"

class Primer::PaginationItemComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_em_if_page_is_current
    render_inline(Primer::PaginationItemComponent.new(page: 1, current_page: 1))

    assert_selector("em", text: "1")
    refute_selector("a", text: "1")
  end

  def test_renders_link_if_page_is_not_current
    render_inline(Primer::PaginationItemComponent.new(page: 1, current_page: 2))

    refute_selector("em", text: "1")
    assert_selector("a", text: "1")
  end
end
