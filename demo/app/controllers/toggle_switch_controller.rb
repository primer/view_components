# frozen_string_literal: true

# For toggle switch previews/tests
class ToggleSwitchController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    sleep 1 unless Rails.env.test?
    head :accepted
  end
end
