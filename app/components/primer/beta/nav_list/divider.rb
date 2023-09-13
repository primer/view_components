# frozen_string_literal: true

module Primer
  module Beta
    class NavList
      # Separator with optional text rendered above groups or between individual items.
      class Divider < Primer::Alpha::ActionList::Divider
        def kind
          :divider
        end
      end
    end
  end
end
