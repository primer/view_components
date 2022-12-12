# frozen_string_literal: true

module Primer
  class Dropdown
    # :nodoc:
    class Menu < Primer::Alpha::Dropdown::Menu
      status :deprecated

      class Item < Primer::Alpha::Dropdown::Menu::Item
        status :deprecated
      end
    end
  end
end
