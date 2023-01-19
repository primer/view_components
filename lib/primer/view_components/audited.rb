# frozen_string_literal: true

require "json"

module Primer
  # :nodoc:
  module ViewComponents
    AUDITED = JSON.parse(
      File.read(
        File.join(File.dirname(__FILE__), "../../../static/audited_at.json")
      )
    ).freeze
  end
end
