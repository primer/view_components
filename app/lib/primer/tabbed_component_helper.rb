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

    def navigation_tag(with_panel)
      with_panel ? :div : :nav
    end

    def tab_container_wrapper(**system_arguments)
      render Primer::TabContainerComponent.new(**system_arguments) do
        yield
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
