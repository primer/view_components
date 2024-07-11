# frozen_string_literal: true

# :nocov:
class AutoCompleteTestController < ApplicationController
  layout false

  def index
    @fruit_list = [
      "Apples",
      "Apricots",
      "Avocado",
      "Ackee",
      "Bananas",
      "Bilberries",
      "Blueberries",
      "Blackberries",
      "Boysenberries",
      "Bread fruit",
      "Cantaloupes (cantalope)",
      "Chocolate-Fruit",
      "Cherimoya",
      "Cherries",
      "Cranberries",
      "Cucumbers",
      "Currants",
      "Dates",
      "Durian",
      "Eggplant",
      "Elderberries",
      "Figs",
      "Gooseberries",
      "Grapes",
      "Grapefruit",
      "Guava"
    ].select { |fruit| fruit.downcase.include?(params["q"].downcase) }
    @visual_type = params[:visual]
    @version = params[:version]

    render :index, formats: [:html, :html_fragment]
  end
end
