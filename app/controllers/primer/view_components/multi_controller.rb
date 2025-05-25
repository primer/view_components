# frozen_string_literal: true

module Primer
  module ViewComponents
    # works with app/forms/multi_input_form.rb
    class MultiController < ApplicationController
      def create
        respond_to do |format|
          format.json { render json: params.permit(:country, :region).to_h }
        end
      end
    end
  end
end
