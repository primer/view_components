# frozen_string_literal: true

# For toggle switch previews/tests
# :nocov:
class ToggleSwitchController < ApplicationController
  class << self
    attr_accessor :last_request
  end

  skip_before_action :verify_authenticity_token

  def create
    self.class.last_request = request

    sleep 1 unless Rails.env.test?

    # this mimics dotcom behavior
    if request.headers["HTTP_REQUESTED_WITH"] != "XMLHttpRequest"
      head :unprocessable_entity
      return
    end

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
