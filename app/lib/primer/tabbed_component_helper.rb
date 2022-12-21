# frozen_string_literal: true

require "active_support/concern"

module Primer
  # Helper to share tab validation logic between components.
  # The component will raise an error if there are 0 or 2+ selected tabs.
  module TabbedComponentHelper
    extend ActiveSupport::Concern

    class MultipleSelectedTabsError < StandardError; end

    def before_render
      validate_single_selected_tab unless Rails.env.production?
    end

    private

    def aria_label_for_page_nav(label)
      @system_arguments[:tag] == :nav ? @system_arguments[:"aria-label"] = label : @body_arguments[:"aria-label"] = label
    end

    def tab_container_wrapper(with_panel:, **system_arguments)
      return yield unless with_panel

      render Primer::Alpha::TabContainer.new(**system_arguments) do
        yield if block_given?
      end
    end

    def validate_single_selected_tab
      raise MultipleSelectedTabsError, "only one tab can be selected" if selected_tabs_count > 1
    end

    def selected_tabs_count
      @selected_tabs_count ||= tabs.count(&:selected)
    end
  end
end
