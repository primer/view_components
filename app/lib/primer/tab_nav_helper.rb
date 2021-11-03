# frozen_string_literal: true

require "active_support/concern"

module Primer
  # Helper to share tab validation logic between components.
  # The component will raise an error if there are 0 or 2+ selected tabs.
  module TabNavHelper
    extend ActiveSupport::Concern

    EXTRA_ALIGN_DEFAULT = :left
    EXTRA_ALIGN_OPTIONS = [EXTRA_ALIGN_DEFAULT, :right].freeze

    def tab_nav_tab_classes(classes)
      class_names(
        "tabnav-tab",
        classes
      )
    end

    def tab_nav_classes(classes)
      class_names(
        "tabnav",
        classes
      )
    end

    def tab_nav_body_classes(classes)
      class_names(
        "tabnav-tabs",
        classes
      )
    end
  end
end
