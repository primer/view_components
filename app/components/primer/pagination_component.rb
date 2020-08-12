# frozen_string_literal: true

module Primer
  class PaginationComponent < Primer::Component
    DEFAULT_MARGIN_PAGES = 1
    DEFAULT_SURROUNDING_PAGES = 2
    DEFAULT_HREF_BUILDER = proc { |page| "##{page}" }

    def initialize(
      page:,
      page_count:,
      show_pages: true,
      margin_pages: DEFAULT_MARGIN_PAGES,
      surrounding_pages: DEFAULT_SURROUNDING_PAGES,
      href_builder: DEFAULT_HREF_BUILDER,
      **kwargs
    )
      @page = page
      @page_count = page_count
      @show_pages = show_pages
      @margin_pages = margin_pages
      @surrounding_pages = surrounding_pages
      @href_builder = href_builder

      @kwargs = kwargs
      @kwargs[:tag] = :nav
      @kwargs[:classes] = class_names(
        "paginate-container",
        @kwargs[:classes]
      )
    end

    def left_margin_pages
      return [] if @margin_pages == 0

      @left_margin_pages ||= (1..@margin_pages)
    end

    def show_left_ellipsis?
      leftmost_surrounding_page = @page - @surrounding_pages

      leftmost_surrounding_page > left_margin_pages.last
    end

    def middle_pages
      leftmost_non_margin_page = [@page - @surrounding_pages, left_margin_pages.last + 1].max
      rightmost_non_margin_page = [@page + @surrounding_pages, right_margin_pages.first - 1].min
      @middle_pages ||= (leftmost_non_margin_page..rightmost_non_margin_page)
    end

    def right_margin_pages
      return [] if @margin_pages == 0

      @right_margin_pages ||= ((@page_count - @margin_pages + 1)..@page_count)
    end

    def show_right_ellipsis?
      rightmost_surrounding_page = @page + @surrounding_pages

      rightmost_surrounding_page < right_margin_pages.first
    end

    def first_page?
      @page == 1
    end

    def last_page?
      @page == @page_count
    end
  end
end
