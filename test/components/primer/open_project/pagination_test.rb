# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectPaginationTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_navigation
    render_inline(Primer::OpenProject::Pagination.new(page_count: 10, current_page: 2))

    assert_selector("nav[aria-label='Pagination']")
    assert_selector(".PaginationContainer")
  end

  def test_renders_page_numbers
    render_inline(Primer::OpenProject::Pagination.new(page_count: 5, current_page: 2))

    assert_selector("a", text: "1")
    assert_selector("a", text: "2")
    assert_selector("a", text: "3")
    assert_selector("a", text: "4")
    assert_selector("a", text: "5")
  end

  def test_marks_current_page
    render_inline(Primer::OpenProject::Pagination.new(page_count: 5, current_page: 3))

    assert_selector("[aria-current='page']", text: "3")
  end

  def test_hides_previous_on_first_page
    render_inline(Primer::OpenProject::Pagination.new(page_count: 5, current_page: 1))

    refute_selector("[rel='prev']")
    assert_selector("[rel='next']")
  end

  def test_hides_next_on_last_page
    render_inline(Primer::OpenProject::Pagination.new(page_count: 5, current_page: 5))

    assert_selector("[rel='prev']")
    refute_selector("[rel='next']")
  end

  def test_renders_ellipsis_for_many_pages
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 30,
        current_page: 10
      )
    )

    assert_selector("[role='presentation']", text: "…")
  end

  def test_show_pages_false_renders_only_prev_next
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 10,
        current_page: 5,
        show_pages: false
      )
    )

    assert_selector("[rel='prev']")
    assert_selector("[rel='next']")

    refute_selector("a", text: "1")
    refute_selector("a", text: "2")
    refute_selector("a", text: "3")
  end

  def test_custom_href_builder
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 5,
        current_page: 2,
        href_builder: ->(page) { "/page/#{page}" }
      )
    )

    assert_selector("a[href='/page/1']")
    assert_selector("a[href='/page/2']")
    assert_selector("a[href='/page/3']")
  end

  def test_raises_when_show_pages_is_invalid
    error = assert_raises(ArgumentError) do
      Primer::OpenProject::Pagination.new(
        page_count: 10,
        current_page: 2,
        show_pages: "invalid"
      )
    end

    assert_equal "show_pages must be a boolean", error.message
  end

  def test_raises_when_current_page_is_too_big
    error = assert_raises(ArgumentError) do
      Primer::OpenProject::Pagination.new(
        page_count: 0,
        current_page: 1
      )
    end

    assert_equal "current_page can't be larger than page_count", error.message
  end

  def test_renders_pages_near_end_without_end_ellipsis
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 20,
        current_page: 18
      )
    )

    assert_selector("a", text: "15")
    assert_selector("a", text: "16")
    assert_selector("a", text: "17")
    assert_selector("a[aria-current='page']", text: "18")
    assert_selector("a", text: "19")
    assert_selector("a", text: "20")

    assert_selector("span.Page[role='presentation']", count: 1, text: "…")
  end

  def test_raises_when_href_builder_is_invalid
    error = assert_raises(ArgumentError) do
      Primer::OpenProject::Pagination.new(
        page_count: 10,
        current_page: 2,
        href_builder: "invalid"
      )
    end

    assert_equal "href_builder must respond to #call", error.message
  end

  def test_raises_when_page_count_is_negative
    error = assert_raises(ArgumentError) do
      Primer::OpenProject::Pagination.new(
        page_count: -1,
        current_page: 1
      )
    end

    assert_equal "page_count must be >= 0", error.message
  end

  def test_raises_when_current_page_is_less_than_one
    error = assert_raises(ArgumentError) do
      Primer::OpenProject::Pagination.new(
        page_count: 10,
        current_page: 0
      )
    end

    assert_equal "current_page must be >= 1", error.message
  end

  def test_raises_when_margin_page_count_is_negative
    error = assert_raises(ArgumentError) do
      Primer::OpenProject::Pagination.new(
        page_count: 10,
        current_page: 2,
        margin_page_count: -1
      )
    end

    assert_equal "margin_page_count must be >= 0", error.message
  end

  def test_raises_when_surrounding_page_count_is_negative
    error = assert_raises(ArgumentError) do
      Primer::OpenProject::Pagination.new(
        page_count: 10,
        current_page: 2,
        surrounding_page_count: -1
      )
    end

    assert_equal "surrounding_page_count must be >= 0", error.message
  end

  def test_raises_when_page_count_is_not_a_number
    error = assert_raises(ArgumentError) do
      Primer::OpenProject::Pagination.new(
        page_count: "invalid",
        current_page: 1
      )
    end

    assert_equal "page_count must be a number", error.message
  end

  def test_raises_when_margin_page_count_is_not_a_number
    error = assert_raises(ArgumentError) do
      Primer::OpenProject::Pagination.new(
        page_count: 10,
        current_page: 1,
        margin_page_count: "invalid"
      )
    end

    assert_equal "margin_page_count must be a number", error.message
  end

  def test_renders_surrounding_pages_without_margins
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 20,
        current_page: 6,
        margin_page_count: 0,
        surrounding_page_count: 1
      )
    )

    assert_selector("a", text: "5")
    assert_selector("a[aria-current='page']", text: "6")
    assert_selector("a", text: "7")

    refute_selector("a", text: "1") # no margin
    refute_selector("a", text: "20")

    assert_selector("span.Page[role='presentation']", text: "…")
  end

  def test_renders_margin_pages_without_surrounding
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 20,
        current_page: 6,
        margin_page_count: 1,
        surrounding_page_count: 0
      )
    )

    assert_selector("a", text: "1")
    assert_selector("a[aria-current='page']", text: "6")
    assert_selector("a", text: "20")

    refute_selector("a", text: "5")
    refute_selector("a", text: "7")

    assert_selector("span.Page[role='presentation']", text: "…")
  end

  def test_renders_only_current_page_with_ellipses_when_no_margin_and_no_surrounding
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 20,
        current_page: 6,
        margin_page_count: 0,
        surrounding_page_count: 0
      )
    )

    assert_selector("a[aria-current='page']", text: "6")

    refute_selector("a", text: "1")
    refute_selector("a", text: "5")
    refute_selector("a", text: "7")
    refute_selector("a", text: "20")

    assert_selector("span.Page[role='presentation']", count: 2, text: "…")
  end

  def test_link_arguments_are_applied_to_page_links
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 5,
        current_page: 2,
        link_arguments: { data: { turbo: false } }
      )
    )

    assert_selector("a[data-turbo='false']", minimum: 1)
  end

  def test_link_arguments_are_not_applied_to_disabled_links
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 5,
        current_page: 1,
        link_arguments: { data: { turbo: false } }
      )
    )

    refute_selector("[rel='prev'][data-turbo='false']")
  end

  def test_link_arguments_are_not_applied_to_break_elements
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 30,
        current_page: 10,
        link_arguments: { data: { turbo: false } }
      )
    )

    refute_selector("span[role='presentation'][data-turbo='false']")
  end

  def test_single_page_does_not_render_pagination
    render_inline(
      Primer::OpenProject::Pagination.new(
        page_count: 1,
        current_page: 1
      )
    )

    refute_selector("nav[aria-label='Pagination']")
    refute_selector(".PaginationContainer")
  end

end
