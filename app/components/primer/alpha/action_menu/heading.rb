# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # Heading used to describe groups within an action menu.
      class Heading < Primer::Alpha::ActionList::Heading
        def initialize(**)
          super

          # Headings don't make sense in a menu context, so use div instead
          @tag = :div
        end
      end
    end
  end
end
