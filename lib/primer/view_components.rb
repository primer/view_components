# frozen_string_literal: true

require "primer/classify"
require "primer/view_components/version"
require "primer/view_components/engine"

module Primer
  # :nodoc:
  module ViewComponents
    DEPRECATION_HORIZON = "1.0"

    # primer/view_components root directory.
    def self.root
      Pathname(File.expand_path(File.join("..", ".."), __dir__))
    end

    # Skip coverage here because only one branch will execute depending on what
    # Rails version you're running.

    # :nocov:
    def self.deprecation
      @deprecation ||=
        if Rails.application.respond_to?(:deprecators)
          Rails.application.deprecators[:primer_view_components] ||= ActiveSupport::Deprecation.new(
            DEPRECATION_HORIZON, "primer_view_components"
          )
        else
          ActiveSupport::Deprecation.instance
        end
    end
    # :nocov:
  end
end
