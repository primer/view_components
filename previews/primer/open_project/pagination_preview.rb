# frozen_string_literal: true

module Primer
  module OpenProject
    # @label Pagination
    class PaginationPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param current_page number
      # @param page_count number
      # @param margin_page_count number
      # @param surrounding_page_count number
      # @param show_pages toggle
      def playground(
        current_page: 6,
        page_count: 20,
        margin_page_count: 1,
        surrounding_page_count: 2,
        show_pages: true
      )
        current_page = (current_page.presence || 6).to_i
        page_count = (page_count.presence || 20).to_i
        margin_page_count = (margin_page_count.presence || 1).to_i
        surrounding_page_count = (surrounding_page_count.presence || 2).to_i

        # Ensure current_page doesn't exceed page_count
        current_page = [current_page, page_count].min
        current_page = [current_page, 1].max # Ensure at least 1

        render(
          Primer::OpenProject::Pagination.new(
            current_page: current_page,
            page_count: page_count,
            margin_page_count: margin_page_count,
            surrounding_page_count: surrounding_page_count,
            show_pages: show_pages,
            href_builder: ->(page) { "#page-#{page}" }
          )
        )
      end

      # @snapshot
      # @label Default
      def default
        render(
          Primer::OpenProject::Pagination.new(
            current_page: 6,
            page_count: 20,
            href_builder: ->(page) { "#page-#{page}" }
          )
        )
      end

      #
      # @!endgroup
    end
  end
end
