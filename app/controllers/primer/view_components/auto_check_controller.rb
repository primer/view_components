# frozen_string_literal: true

module Primer
  module ViewComponents
    # For auto-check previews
    class AutoCheckController < ApplicationController
      def error
        render partial: "primer/view_components/auto_check/error_message",
          locals: { input_value: params[:value] },
          status: :unprocessable_entity,
          formats: :html
      end

      def ok
        head :ok
      end

      def accepted
        render partial: "primer/view_components/auto_check/warning_message",
          locals: { input_value: params[:value] },
          status: :accepted,
          formats: :html
      end

      def random
        roll = rand
        if roll < 0.33
          head :ok
        elsif roll < 0.66
          render partial: "primer/view_components/auto_check/success_message",
            locals: { input_value: params[:value] },
            status: :ok,
            formats: :html
        else
          render status: :unprocessable_entity, plain: "Random error!"
        end
      end
    end
  end
end
