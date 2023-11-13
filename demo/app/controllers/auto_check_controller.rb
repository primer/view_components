# frozen_string_literal: true

# For auto-check previews
# :nocov:
class AutoCheckController < ApplicationController
  skip_before_action :verify_authenticity_token

  def error
    render partial: "auto_check/error_message",
      locals: { input_value: params[:value] },
      status: :unprocessable_entity,
      formats: :html
  end

  def ok
    head :ok
  end

  def accepted
    render partial: "auto_check/warning_message",
      locals: { input_value: params[:value] },
      status: :accepted,
      formats: :html
  end

  def random
    if rand > 0.5
      head :ok
    else
      render status: :unprocessable_entity, plain: "Random error!"
    end
  end
end
