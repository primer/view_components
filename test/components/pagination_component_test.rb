# frozen_string_literal: true

require "test_helper"

class Primer::PaginationComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_a_pagination_container
    render_inline(Primer::PaginationComponent.new(current_page: 1, page_count: 1))

    assert_selector("nav.paginate-container")
    assert_selector("div.pagination")
  end

  def test_does_not_render_numbers_if_show_pages_is_false
    render_inline(Primer::PaginationComponent.new(current_page: 1, page_count: 10, show_pages: false))

    assert_selector(".previous_page", text: "Previous")
    assert_selector(".next_page", text: "Next")
  end

  def test_defaults_to_rendering_1_first_and_last_pages
    render_inline(Primer::PaginationComponent.new(current_page: 5, page_count: 10))

    assert_selector("a", text: "1")
    assert_selector("a", text: "10")
    refute_selector("a", text: "2")
    refute_selector("a", text: "9")
  end

  def test_renders_n_first_and_last_pages_when_specified
    n = 3
    render_inline(Primer::PaginationComponent.new(current_page: 10, page_count: 20, margin_page_count: n))

    n.times do |i|
      assert_selector("a", text: "#{i + 1}")
      assert_selector("a", text: "#{20 - i}")
    end
  end

  def test_defaults_to_rendering_2_pages_on_each_side_of_current
    n = Primer::PaginationComponent::DEFAULT_SURROUNDING_PAGES

    render_inline(Primer::PaginationComponent.new(current_page: 10, page_count: 20))

    assert_selector("em", text: "10")
    (1..n).each do |i|
      assert_selector("a", text: "#{10 + i}")
      assert_selector("a", text: "#{10 - i}")
    end
    refute_selector("a", text: "#{10 + n + 1}")
    refute_selector("a", text: "#{10 + n + 1}")
  end

  def test_renders_n_pages_on_each_side_of_current_when_specified
    n = 5

    render_inline(Primer::PaginationComponent.new(current_page: 10, page_count: 20, surrounding_page_count: n))

    assert_selector("em", text: "10")
    (1..n).each do |i|
      assert_selector("a", text: "#{10 + i}")
      assert_selector("a", text: "#{10 - i}")
    end
    refute_selector("a", text: "#{10 + n + 1}")
    refute_selector("a", text: "#{10 + n + 1}")
  end

  def test_href_builder_defaults_to_hashtag_number
    render_inline(Primer::PaginationComponent.new(current_page: 1, page_count: 2))

    assert_selector("em", text: "1")
    assert_selector("a[href='#2']", text: "2")
  end

  def test_calls_custom_href_builder
    builder = proc { |page| "page-number-#{page}" }
    render_inline(Primer::PaginationComponent.new(current_page: 1, page_count: 2, href_builder: builder))

    assert_selector("em", text: "1")
    assert_selector("a[href='page-number-2']", text: "2")
  end

  def test_renders_left_gap_if_surround_pages_arent_part_of_left_margin
    render_inline(Primer::PaginationComponent.new(current_page: 3, page_count: 3, surrounding_page_count: 0, margin_page_count: 1))

    assert_selector("span.gap", count: 1)
  end

  def test_renders_right_gap_if_surround_pages_arent_part_of_right_margin
    render_inline(Primer::PaginationComponent.new(current_page: 1, page_count: 3, surrounding_page_count: 0, margin_page_count: 1))

    assert_selector("span.gap", count: 1)
  end

  def test_renders_both_gaps_if_surround_pages_arent_part_of_any_margin
    render_inline(Primer::PaginationComponent.new(current_page: 3, page_count: 5, surrounding_page_count: 0, margin_page_count: 1))

    assert_selector("span.gap", count: 2)
  end

  def test_renders_no_if_surround_pages_aren_part_of_both_margins
    render_inline(Primer::PaginationComponent.new(current_page: 3, page_count: 5, surrounding_page_count: 1, margin_page_count: 1))

    refute_selector("span.gap")
  end
end
