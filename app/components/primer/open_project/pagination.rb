# frozen_string_literal: true

module Primer
  module OpenProject
    class Pagination < Primer::Component
      status :open_project

      PageData = Struct.new(:key, :content, :props, keyword_init: true)

      DEFAULT_MARGIN_PAGE_COUNT = 1
      DEFAULT_SURROUNDING_PAGE_COUNT = 2

      PAGE_TYPE__BREAK = :break
      PAGE_TYPE__PREV = :prev
      PAGE_TYPE__NEXT = :next
      PAGE_TYPE__NUM = :num

      attr_reader :page_count,
                  :current_page,
                  :href_builder,
                  :margin_page_count,
                  :show_pages,
                  :surrounding_page_count

      def initialize(
        page_count:,
        current_page:,
        href_builder: nil,
        margin_page_count: DEFAULT_MARGIN_PAGE_COUNT,
        show_pages: true,
        surrounding_page_count: DEFAULT_SURROUNDING_PAGE_COUNT,
        link_arguments: {},
        **system_arguments
      )
        @page_count = cast_integer!(page_count, "page_count")
        @current_page = cast_integer!(current_page, "current_page")
        @href_builder = href_builder || method(:default_href_builder)
        @margin_page_count = cast_integer!(margin_page_count, "margin_page_count")
        @show_pages = show_pages
        @surrounding_page_count = cast_integer!(surrounding_page_count, "surrounding_page_count")
        @link_arguments = link_arguments
        @system_arguments = system_arguments

        @system_arguments[:tag] = :nav
        @system_arguments[:classes] = class_names(
          "PaginationContainer",
          @system_arguments[:classes]
        )
        @system_arguments["aria-label"] = I18n.t("pagination.label")

        validate_arguments!
      end

      def pages
        build_pagination_model.map do |page|
          build_component_data(page)
        end
      end

      private

      def cast_integer!(value, name)
        Integer(value)
      rescue ArgumentError, TypeError
        raise ArgumentError, "#{name} must be a number"
      end

      def validate_arguments!
        raise ArgumentError, "page_count must be >= 0" if page_count < 0
        raise ArgumentError, "current_page must be >= 1" if current_page < 1
        raise ArgumentError, "margin_page_count must be >= 0" if margin_page_count < 0
        raise ArgumentError, "surrounding_page_count must be >= 0" if surrounding_page_count < 0
        raise ArgumentError, "href_builder must respond to #call" unless href_builder.respond_to?(:call)
        raise ArgumentError, "show_pages must be a boolean" unless [true, false].include?(show_pages)
        raise ArgumentError, "current_page can't be larger than page_count" if current_page > page_count
        raise ArgumentError, "link_arguments must be a Hash" unless @link_arguments.is_a?(Hash)
      end

      def default_href_builder(page_num)
        "##{page_num}"
      end

      def build_pagination_model
        pages = []

        pages << previous_page_item unless first_page?
        pages.concat(number_page_items) if show_pages
        pages << next_page_item unless last_page?

        pages
      end

      def previous_page_item
        {
          type: PAGE_TYPE__PREV,
          num: current_page - 1
        }
      end

      def next_page_item
        {
          type: PAGE_TYPE__NEXT,
          num: current_page + 1
        }
      end

      def first_page?
        current_page == 1
      end

      def last_page?
        current_page == page_count
      end

      def number_page_items
        if all_pages_fit?
          full_pagination_without_breaks
        else
          paginated_number_items
        end
      end

      def full_pagination_without_breaks
        pages = []
        add_pages(pages, 1, page_count)
        pages
      end

      def paginated_number_items
        pages = []

        add_start_pages_and_ellipsis(pages)
        add_middle_pages(pages)
        add_end_pages_and_ellipsis(pages)

        pages
      end

      def add_start_pages_and_ellipsis(pages)
        add_pages(pages, 1, margin_page_count, has_start_ellipsis?)
        add_ellipsis(pages, margin_page_count) if has_start_ellipsis?
      end

      def add_middle_pages(pages)
        add_pages(
          pages,
          middle_start_page,
          middle_end_page,
          has_end_ellipsis?
        )
      end

      def add_end_pages_and_ellipsis(pages)
        add_ellipsis(pages, middle_end_page) if has_end_ellipsis?
        add_pages(pages, ending_start_page, page_count)
      end

      def all_pages_fit?
        page_count <= max_visible_pages
      end

      def max_visible_pages
        # The standard gap on the left and the right +
        # current page + 2 boundary pages (one on each side before an ellipsis would appear)
        (standard_gap * 2) + 3
      end

      def standard_gap
        surrounding_page_count + margin_page_count
      end

      def has_start_ellipsis?
        start_gap.positive?
      end

      def has_end_ellipsis?
        end_gap.positive?
      end

      def start_gap
        @start_gap ||= near_start? ? 0 : current_page - standard_gap - 1
      end

      def start_offset
        @start_offset ||= near_start? ? current_page - standard_gap - 2 : 0
      end

      def end_gap
        @end_gap ||= near_end? ? 0 : page_count - current_page - standard_gap
      end

      def end_offset
        @end_offset ||= near_end? ? page_count - current_page - standard_gap - 1 : 0
      end

      def near_start?
        current_page - standard_gap - 1 <= 1
      end

      def near_end?
        page_count - current_page - standard_gap <= 1
      end

      def middle_start_page
        margin_page_count + start_gap + end_offset + 1
      end

      def middle_end_page
        page_count - start_offset - end_gap - margin_page_count
      end

      def ending_start_page
        page_count - margin_page_count + 1
      end

      def add_ellipsis(pages, previous_page)
        pages << {
          type: PAGE_TYPE__BREAK,
          num: previous_page + 1
        }
      end

      def add_pages(pages, start_page, end_page, precedes_break = false)
        (start_page..end_page).each do |i|
          pages << {
            type: PAGE_TYPE__NUM,
            num: i,
            selected: i == current_page,
            precedes_break: i == end_page && precedes_break
          }
        end
      end

      def build_component_data(page)
        props = {}
        content = ""
        key = ""

        case page[:type]
        when PAGE_TYPE__PREV, PAGE_TYPE__NEXT
          key = page[:type]
          key_string = key.to_s
          content = I18n.t("pagination.#{key_string}")

          props.merge!(
            rel: key_string,
            href: href_builder.call(page[:num]),
            "aria-label": I18n.t("pagination.#{key_string}_page"),
            **@link_arguments
          )

        when PAGE_TYPE__NUM
          key = :"page-#{page[:num]}"
          content = page[:num].to_s

          props.merge!(
            href: href_builder.call(page[:num]),
            "aria-label": page[:precedes_break] ? I18n.t("pagination.page_with_more", number: page[:num]) : I18n.t("pagination.page", number: page[:num]),
            **@link_arguments
          )

          props[:"aria-current"] = "page" if page[:selected]

        when PAGE_TYPE__BREAK
          key = :"page-#{page[:num]}-break"
          content = "…"

          props.merge!(
            role: "presentation"
          )
        end

        props[:class] = class_names("Page", props[:class])

        PageData.new(
          key: key,
          content: content,
          props: props
        )
      end
    end
  end
end
