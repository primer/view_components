# frozen_string_literal: true
class HealthController < ApplicationController
  def index
    head :ok
  end
end