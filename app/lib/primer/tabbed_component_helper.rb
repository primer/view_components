# frozen_string_literal: true

require "active_support/concern"

module Primer
  module TabbedComponentHelper
    extend ActiveSupport::Concern

    included do
      include ViewComponent::SlotableV2
    end

    class MultipleSelectedTabsError < StandardError; end
    class NoSelectedTabsError < StandardError; end

    def before_render
      validate_single_selected_tab
    end

    private

    def validate_single_selected_tab
      raise MultipleSelectedTabsError, "only one tab can be selected" if selected_tabs_count > 1
      raise NoSelectedTabsError, "a tab must be selected" if selected_tabs_count != 1
    end

    def selected_tabs_count
      @selected_tabs_count ||= tabs.count(&:selected)
    end
  end
end