# frozen_string_literal: true

module Primer
  # :nodoc:
  module JoinStyleArgumentsHelper
    # Join two `style` arguments
    #
    # join_style_arguments("width: 100%", "height: 100%") =>
    #   "width: 100%;height: 100%"
    def join_style_arguments(*args)
      args.compact.join(";")
    end
  end
end
