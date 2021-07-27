# frozen_string_literal: true

require "json"

module Primer
  # :nodoc:
  module ViewComponents
    CONSTANTS = JSON.parse(
      File.read(
        File.join(File.dirname(__FILE__), "../../../static/constants.json")
      )
    ).freeze
  end
end
