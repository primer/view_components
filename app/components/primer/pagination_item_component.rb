# frozen_string_literal: true

module Primer
  class PaginationItemComponent < Primer::Component
    DEFAULT_HREF_BUILDER = proc { |page| "##{page}" }

    def initialize(page:, current_page:, href_builder: DEFAULT_HREF_BUILDER, **kwargs)
      @page = page
      @href_builder = href_builder
      @kwargs = kwargs

      @is_current = page == current_page
    end
  end
end
