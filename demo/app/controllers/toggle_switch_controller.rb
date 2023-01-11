# frozen_string_literal: true

# For toggle switch previews/tests
# :nocov:
class ToggleSwitchController < ApplicationController
  class << self
    attr_accessor :last_request
  end

  skip_before_action :verify_authenticity_token

  before_action :reject_non_ajax_request
  before_action :verify_artificial_authenticity_token

  def create
    # lol this is so not threadsafe
    self.class.last_request = request

    sleep 1 unless Rails.env.test?

    head :accepted
  end

  private

  # this mimics dotcom behavior
  def reject_non_ajax_request
    return if request.headers["HTTP_REQUESTED_WITH"] == "XMLHttpRequest"

    head :unprocessable_entity
  end

  def verify_artificial_authenticity_token
    # don't check token if not provided
    return unless form_params[:authenticity_token]

    # if provided, check token
    return if form_params[:authenticity_token] == "let_me_in"

    render status: :unauthorized, plain: "Bad CSRF token (someone's trying to XHR you!)"
  end

  def form_params
    params.permit(:value, :authenticity_token)
  end
end
