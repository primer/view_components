# frozen_string_literal: true

# For toggle switch previews/tests
class ToggleSwitchController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    sleep 1 unless Rails.env.test?

    if form_params[:authenticity_token] && form_params[:authenticity_token] != "let_me_in"
      head :unauthorized
      return
    end

    head :accepted
  end

  private

  def form_params
    params.permit(:value, :authenticity_token)
  end
end
