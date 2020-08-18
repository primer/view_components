module Primer
  module StoriesHelper
    class << self
      def array_to_options(arr)
        arr.each_with_object({}) { |k, h| h[k] = k }
      end
    end
  end
end
