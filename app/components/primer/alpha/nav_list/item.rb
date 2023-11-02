# frozen_string_literal: true

module Primer
  module Alpha
    class NavList
      # :nodoc:
      class Item < Beta::NavList::Item
        status :deprecated
      end
    end
  end
end
