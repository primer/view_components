# frozen_string_literal: true

# For auto-check previews
# :nocov:
class AutoCheckController < ApplicationController
  skip_before_action :verify_authenticity_token

  def error
    render status: :unprocessable_entity, plain: "Error! Error!"
  end

  def ok
    head :ok
  end

  def random
    if rand > 0.5
      head :ok
    else
      render status: :unprocessable_entity, plain: "Random error!"
    end
  end
end
