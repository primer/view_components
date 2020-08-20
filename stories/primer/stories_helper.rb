# frozen_string_literal: true

module Primer
  module StoriesHelper
    class << self
      ##
      # Transforms an array of values into a hash
      # with keys = values
      #
      # [1,2,3] => { 1 => 1, 2 => 2, 3 => 3 }
      # [:a, :b, :c] => { :a => :a, :b => :b, :c => :c }
      ##
      def array_to_options(arr)
        arr.each_with_object({}) { |k, h| h[k] = k }
      end
    end
  end
end
