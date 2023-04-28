# frozen_string_literal: true

module Primer
  module Alpha
    class NavList
      # Separator with optional text rendered above groups or between individual items.
      class Divider < Primer::Alpha::ActionList::Divider
        def group?
          false
        end

        def divider?
          true
        end
      end
    end
  end
end
