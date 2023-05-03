# frozen_string_literal: true

# Necessary for Lookbook, see config/routes.rb
# :nocov:
class HomeController < ApplicationController
  def index
    head :ok
  end
end
