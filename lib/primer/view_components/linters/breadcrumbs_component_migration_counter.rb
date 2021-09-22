# frozen_string_literal: true

require_relative "base_linter"

module ERBLint
  module Linters
    # Counts the number of times a HTML breadcrumbs is used instead of the component.
    class BreadcrumbsComponentMigrationCounter < BaseLinter
      MESSAGE = "We are migrating breadcrumbs to use [Primer::Breadcrumbs](https://primer.style/view-components/components/beta/breadcrumbs), please try to use that instead of raw HTML."
      CLASSES = %w[breadcrumb-item breadcrumb-item-selected].freeze
      TAGS = %w[li].freeze
    end
  end
end
