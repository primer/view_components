# frozen_string_literal: true

require "active_support/concern"

module Primer
  # Helper to share tab validation logic between components.
  # The component will raise an error if there are 0 or 2+ selected tabs.
  module UnderlineNavHelper
    extend ActiveSupport::Concern

    ALIGN_DEFAULT = :left
    ALIGN_OPTIONS = [ALIGN_DEFAULT, :right].freeze

    ACTIONS_TAG_DEFAULT = :div
    ACTIONS_TAG_OPTIONS = [ACTIONS_TAG_DEFAULT, :span].freeze

    def underline_nav_classes(classes, align)
      class_names(
        classes,
        "UnderlineNav",
        "UnderlineNav--right" => align == :right
      )
    end

    def underline_nav_body_classes(classes)
      class_names(
        "UnderlineNav-body",
        classes,
        "list-style-none"
      )
    end

    def underline_nav_action_classes(classes)
      class_names("UnderlineNav-actions", classes)
    end

    def underline_nav_tab_classes(classes)
      class_names(
        "UnderlineNav-item",
        classes
      )
    end
  end
end
