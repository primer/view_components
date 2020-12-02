module Primer
  module JoinStyleArgumentsHelper
    # Join two `style` arguments
    #
    # join_style_arguments("width: 100%", "height: 100%") =>
    #   "width: 100%;height: 100%"
    def join_style_arguments(first, second)
      [first, second].compact.join(";")
    end
  end
end
