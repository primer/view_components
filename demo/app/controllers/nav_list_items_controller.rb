# frozen_string_literal: true

# For nav list previews/tests
# :nocov:
class NavListItemsController < ApplicationController
  layout false

  FOODS = [
    { label: "Bachelor Chow", href: "/foods/bachelor-chow" },
    { label: "LöBrau", href: "/foods/lobrau" },
    { label: "Taco Bellevue Hospital", href: "/foods/taco-bellevue-hospital" },
    { label: "Olde Fortran", href: "/foods/olde-fortran" },
    { label: "Space Honey", href: "/foods/space-honey" },
    { label: "Spice Weasel", href: "/foods/spice-weasel" },
  ]

  def index
    items_per_page = 2
    # the first page is already shown in the nav list, so we need to offset the starting index
    start_index = (params[:page].to_i - items_per_page) * items_per_page
    @data = FOODS.slice(start_index, items_per_page)
    @list = Primer::Beta::NavList::Group.new  # dummy group
  end
end
