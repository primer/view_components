# frozen_string_literal: true

require "primer/classify"
require "primer/view_components/version"
require "primer/view_components/engine"

module Primer
  # :nodoc:
  module ViewComponents
    # primer/view_components root directory.
    def self.root
      Pathname(File.expand_path(File.join("..", ".."), __dir__))
    end
  end
end
