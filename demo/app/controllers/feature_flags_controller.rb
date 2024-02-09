# frozen_string_literal: true

# :nocov:
class FeatureFlagsController < ApplicationController
  def index
  end

  def update
    cookies[params[:id]] = (params[:value] === "1").to_s
    # called via toggle switch ajax, return empty response
  end

  private

  def flag_params
    params.permit(:id, :value)
  end
end
