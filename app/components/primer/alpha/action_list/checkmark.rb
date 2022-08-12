# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # :nodoc:
      class Checkmark < Primer::Component
        def initialize(select_mode:)
          @select_mode = select_mode
        end

        def render?
          @select_mode != :none
        end
      end
    end
  end
end
