# frozen_string_literal: true

# :nodoc:
class HealthController < ApplicationController
  def index
    head :ok
  end
end
