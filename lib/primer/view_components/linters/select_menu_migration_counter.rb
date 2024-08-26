# frozen_string_literal: true

require_relative "base_linter"

module ERBLint
  module Linters
    # Counts the number of times a HTML SelectMenu is used instead of the SelectPanel component.
    class SelectMenuMigrationCounter < BaseLinter
      MESSAGE = "Please use the [Primer::Alpha::SelectPanel](https://primer.style/components/selectpanel/rails/alpha) component instead of SelectMenu."
      CLASSES = ["SelectMenu", /\ASelectMenu-.*/].freeze
      TAGS = [].freeze
    end
  end
end
