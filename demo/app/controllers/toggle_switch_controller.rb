# frozen_string_literal: true

# For toggle switch previews/tests
# :nocov:
class ToggleSwitchController < ApplicationController
  class << self
    attr_accessor :last_request
  end

  skip_before_action :verify_authenticity_token

  before_action :reject_ajax_request
  before_action :verify_artificial_authenticity_token

  def create
    self.class.last_request = request

    sleep 1 unless Rails.env.test?

    head :accepted
  end

  def only_accept_on
    return head(:accepted) if form_params[:value] == "1"
    head :bad_request
  end

  def only_accept_off
    return head(:accepted) if form_params[:value] == "0"
    head :bad_request
  end

  private

  def reject_ajax_request
    # this mimics dotcom behavior
    if request.headers["HTTP_REQUESTED_WITH"] != "XMLHttpRequest"
      head :unprocessable_entity
    end
  end

  def verify_artificial_authenticity_token
    if form_params[:authenticity_token] && form_params[:authenticity_token] != "let_me_in"
      head :unauthorized
    end
  end

  def form_params
    params.permit(:value, :authenticity_token)
  end
end
