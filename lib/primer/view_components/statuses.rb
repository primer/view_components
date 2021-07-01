# frozen_string_literal: true

require "json"

module Primer
  # :nodoc:
  module ViewComponents
    STATUSES = JSON.parse(
      File.read(
        File.join(File.dirname(__FILE__), "../../../static/statuses.json")
      )
    ).freeze
  end
end
