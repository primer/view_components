# frozen_string_literal: true

module Primer
  module ViewComponents
    # For toggle switch previews/tests
    # :nocov:
    class ToggleSwitchController < ApplicationController
      class << self
        attr_accessor :last_request
      end

      rescue_from ActionController::InvalidAuthenticityToken, with: :handle_invalid_authenticity_token

      before_action :reject_non_ajax_request

      def create
        # lol this is so not threadsafe
        self.class.last_request = request

        sleep 1 unless Rails.env.test?

        if params[:fail] == "true"
          render status: :internal_server_error, plain: "Something went wrong."
          return
        end

        head :accepted
      end

      private

      def handle_invalid_authenticity_token
        render status: :unauthorized, plain: "Bad CSRF token."
      end

      # this mimics dotcom behavior
      def reject_non_ajax_request
        return if request.headers["HTTP_REQUESTED_WITH"] == "XMLHttpRequest"

        head :unprocessable_entity
      end

      def form_params
        params.permit(:value, :authenticity_token)
      end
    end
  end
end
