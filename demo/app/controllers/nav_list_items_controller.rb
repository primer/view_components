# frozen_string_literal: true

# For nav list previews/tests
# :nocov:
class NavListItemsController < ApplicationController
  layout false

  PAGES = {
    2 => [
      { label: "Bachelor Chow", href: "/foods/bachelor-chow" },
      { label: "LöBrau", href: "/foods/lobrau" }
    ]
  }

  def index
    @data = PAGES[params[:page].to_i]
  end
end
