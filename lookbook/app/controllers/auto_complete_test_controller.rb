# frozen_string_literal: true

# no doc
class AutoCompleteTestController < ApplicationController
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
    ].select { |fruit| fruit.include?(params["q"]) }
  end
end
