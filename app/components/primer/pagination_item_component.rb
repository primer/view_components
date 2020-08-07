# frozen_string_literal: true

module Primer
  class PaginationItemComponent < Primer::Component
    def initialize(page:, current_page:, href_builder:)
      @page = page
      @href_builder = href_builder

      @is_current = page == current_page
    end
  end
end
