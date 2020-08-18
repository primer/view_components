# frozen_string_literal: true

module Primer
  class PaginationComponent < Primer::Component
    DEFAULT_MARGIN_PAGES = 1
    DEFAULT_SURROUNDING_PAGES = 2
    DEFAULT_HREF_BUILDER = proc { |page| "##{page}" }

    def initialize(
      current_page:,
      page_count:,
      show_pages: true,
      margin_page_count: DEFAULT_MARGIN_PAGES,
      surrounding_page_count: DEFAULT_SURROUNDING_PAGES,
      href_builder: DEFAULT_HREF_BUILDER,
      **kwargs
    )
      @current_page = current_page
      @page_count = page_count
      @show_pages = show_pages
      @margin_page_count = margin_page_count
      @surrounding_page_count = surrounding_page_count
      @href_builder = href_builder

      @kwargs = kwargs
      @kwargs[:tag] = :nav
      @kwargs[:classes] = class_names(
        "paginate-container",
        @kwargs[:classes]
      )
    end

    def left_margin_pages
      return [] if @margin_page_count == 0

      @left_margin_pages ||= (1..@margin_page_count)
    end

    def show_left_ellipsis?
      leftmost_surrounding_page = @current_page - @surrounding_page_count

      # We don't show ellipsis if the leftmost surrounding page
      # is either in the margin pages or is the page after the left margin
      leftmost_surrounding_page > left_margin_pages.last + 1
    end

    def middle_pages
      leftmost_non_margin_page = [@current_page - @surrounding_page_count, left_margin_pages.last + 1].max
      rightmost_non_margin_page = [@current_page + @surrounding_page_count, right_margin_pages.first - 1].min
      @middle_pages ||= (leftmost_non_margin_page..rightmost_non_margin_page)
    end

    def right_margin_pages
      return [] if @margin_page_count == 0

      @right_margin_pages ||= ((@page_count - @margin_page_count + 1)..@page_count)
    end

    def show_right_ellipsis?
      rightmost_surrounding_page = @current_page + @surrounding_page_count

      # We don't show ellipsis if the rightmost surrounding page
      # is either in the margin pages or is the page before the right margin
      rightmost_surrounding_page < right_margin_pages.first - 1
    end

    def first_page?
      @current_page == 1
    end

    def last_page?
      @current_page == @page_count
    end
  end
end
